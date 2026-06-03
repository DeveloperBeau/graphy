//! Kotlin extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_kotlin_ng::LANGUAGE.into())
        .context("load tree-sitter-kotlin-ng")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
}

/// The tree-sitter-kotlin-ng grammar uses `class_declaration` for class,
/// interface, enum class, sealed class, data class, etc. Distinguish by
/// looking for the first unnamed keyword child.
fn kotlin_class_kind(node: tree_sitter::Node, src: &str) -> &'static str {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if !c.is_named() {
            match c.utf8_text(src.as_bytes()).unwrap_or("") {
                "interface" => return "interface",
                "enum" => return "class", // enum class -> kind=class (enum body is separate)
                _ => return "class",
            }
        }
    }
    "class"
}

/// Extract the leaf type name from a Kotlin type node.
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "user_type" => {
            // Direct `identifier` children, one per dotted segment. Use the
            // last so `java.util.Locale` yields `Locale`; for `Widget` the
            // single child is also the last.
            let mut c = node.walk();
            node.children(&mut c)
                .filter(|ch| ch.kind() == "identifier")
                .last()
                .and_then(|ch| ch.utf8_text(src.as_bytes()).ok())
                .map(|s| s.to_string())
        }
        "nullable_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find(|ch| matches!(ch.kind(), "user_type" | "nullable_type"))
                .and_then(|ch| extract_type_leaf(ch, src))
        }
        _ => None,
    }
}

/// Kotlin primitive / builtin types that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "Int"
            | "Long"
            | "Short"
            | "Byte"
            | "Float"
            | "Double"
            | "Boolean"
            | "Char"
            | "String"
            | "Unit"
            | "Nothing"
            | "Any"
    )
}

/// First named child of `parent` whose kind is a concrete type node.
fn first_type_child(parent: TsNode) -> Option<TsNode> {
    let mut c = parent.walk();
    parent
        .children(&mut c)
        .find(|ch| matches!(ch.kind(), "user_type" | "nullable_type"))
}

/// First named `identifier` child text of `parent`.
fn first_identifier(parent: TsNode, src: &str) -> Option<String> {
    let mut c = parent.walk();
    parent
        .children(&mut c)
        .find(|ch| ch.kind() == "identifier")
        .and_then(|ch| ch.utf8_text(src.as_bytes()).ok())
        .map(|s| s.to_string())
}

/// Push a `kind:"type"` extern node for a non-primitive leaf.
fn push_type_node(out: &mut ExtractionOutput, file: &str, leaf: &str, node: TsNode) {
    out.nodes.push(Node {
        id: format!("extern::{leaf}"),
        label: leaf.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(node)),
        kind: Some("type".into()),
        signature: None,
    });
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges.
fn kotlin_fn_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let mut params_node: Option<TsNode> = None;
    let mut cursor = decl.walk();
    for child in decl.children(&mut cursor) {
        if child.kind() == "function_value_parameters" {
            params_node = Some(child);
            break;
        }
    }
    if let Some(params) = params_node {
        let mut pc = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut pc) {
            if p.kind() != "parameter" {
                continue;
            }
            let name = first_identifier(p, src).unwrap_or_else(|| "_".to_string());
            let ty_node = first_type_child(p);
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let leaf = ty_node
                .and_then(|t| extract_type_leaf(t, src))
                .filter(|l| !is_primitive_or_ignored(l));
            if let Some(ref leaf) = leaf {
                out.edges.push(Edge {
                    source: fn_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_param".into(),
                    confidence: Confidence::Extracted,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                push_type_node(out, file, leaf, p);
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    // Return type: first concrete type node appearing after the parameter
    // list (positional — avoids reading an extension-function receiver).
    let mut seen_params = false;
    let mut rc = decl.walk();
    let mut ret_node: Option<TsNode> = None;
    for child in decl.children(&mut rc) {
        if child.kind() == "function_value_parameters" {
            seen_params = true;
            continue;
        }
        if seen_params && matches!(child.kind(), "user_type" | "nullable_type") {
            ret_node = Some(child);
            break;
        }
    }
    if let Some(ret) = ret_node {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            sig.returns = Some(text.trim().to_string());
        }
        if let Some(leaf) = extract_type_leaf(ret, src).filter(|l| !is_primitive_or_ignored(l)) {
            out.edges.push(Edge {
                source: fn_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "returns".into(),
                confidence: Confidence::Extracted,
                attr: None,
            });
            push_type_node(out, file, &leaf, ret);
        }
    }
    sig
}

/// Emit a `has_field` edge + extern type node + push a `FieldSig`.
#[allow(clippy::too_many_arguments)]
fn emit_field(
    out: &mut ExtractionOutput,
    sig: &mut Signature,
    file: &str,
    type_id: &str,
    name: String,
    ty_node: Option<TsNode>,
    loc_node: TsNode,
    src: &str,
) {
    let ty_text = ty_node
        .and_then(|t| t.utf8_text(src.as_bytes()).ok())
        .map(|s| s.trim().to_string());
    let leaf = ty_node
        .and_then(|t| extract_type_leaf(t, src))
        .filter(|l| !is_primitive_or_ignored(l));
    if let Some(leaf) = &leaf {
        out.edges.push(Edge {
            source: type_id.to_string(),
            target: format!("extern::{leaf}"),
            relation: "has_field".into(),
            confidence: Confidence::Extracted,
            attr: Some(EdgeAttr {
                name: Some(name.clone()),
                index: None,
            }),
        });
        push_type_node(out, file, leaf, loc_node);
    }
    sig.fields.push(FieldSig { name, ty: ty_text });
}

/// Build a class `Signature.fields` and emit `has_field` edges. Processes
/// constructor `val`/`var` properties and class-body property declarations
/// only — methods are handled by the `walk()` recursion.
fn kotlin_class_signature(
    class_decl: TsNode,
    src: &str,
    file: &str,
    class_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();

    // Constructor `val`/`var` properties.
    let mut cc = class_decl.walk();
    let primary = class_decl
        .children(&mut cc)
        .find(|c| c.kind() == "primary_constructor");
    if let Some(primary) = primary {
        let mut pc = primary.walk();
        if let Some(params) = primary
            .children(&mut pc)
            .find(|c| c.kind() == "class_parameters")
        {
            let mut cp = params.walk();
            for param in params.children(&mut cp) {
                if param.kind() != "class_parameter" {
                    continue;
                }
                // Emit a field only for `val`/`var` (property) parameters.
                let mut vc = param.walk();
                let is_property = param.children(&mut vc).any(|c| {
                    !c.is_named() && matches!(c.utf8_text(src.as_bytes()), Ok("val") | Ok("var"))
                });
                if !is_property {
                    continue;
                }
                if let Some(name) = first_identifier(param, src) {
                    emit_field(
                        out,
                        &mut sig,
                        file,
                        class_id,
                        name,
                        first_type_child(param),
                        param,
                        src,
                    );
                }
            }
        }
    }

    // Class-body property declarations.
    let mut bc = class_decl.walk();
    if let Some(body) = class_decl
        .children(&mut bc)
        .find(|c| c.kind() == "class_body")
    {
        let mut pc = body.walk();
        for prop in body.children(&mut pc) {
            if prop.kind() != "property_declaration" {
                continue;
            }
            let mut vc = prop.walk();
            if let Some(var) = prop
                .children(&mut vc)
                .find(|c| c.kind() == "variable_declaration")
                && let Some(name) = first_identifier(var, src)
            {
                emit_field(
                    out,
                    &mut sig,
                    file,
                    class_id,
                    name,
                    first_type_child(var),
                    prop,
                    src,
                );
            }
        }
    }

    sig
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = kotlin_fn_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_declaration" => {
                if let Some(n) = name_of(child, src) {
                    // The tree-sitter-kotlin-ng grammar uses class_declaration
                    // for class, interface, object, enum class, data class, etc.
                    // Distinguish by first unnamed keyword child.
                    let kind = kotlin_class_kind(child, src);
                    let id = format!("{file}::{n}");
                    let sig = kotlin_class_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, kind, n, child);
                    attach_signature(out, sig);
                }
            }
            "object_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "object", n, child);
                }
            }
            "import_header" | "import_directive" | "import" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("import")
                    .trim()
                    .trim_end_matches(';');
                emit_import(out, file, target, child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}

fn walk_calls(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_declaration"
            && let Some(name) = name_of(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
    }
}

fn collect_calls(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0)
        {
            let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
