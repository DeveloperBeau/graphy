//! C# extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

/// Recursively collect leaf type names from a C# type node. A keyword primitive
/// (`predefined_type`, e.g. `string`) is skipped. A `generic_name` pushes its
/// BASE name (via the `identifier` arm) then recurses into each type argument:
/// `List<Widget>` -> `[List, Widget]`, `Pair<Foo, Bar>` -> `[Pair, Foo, Bar]`.
/// Container suppression happens at the emit site via `is_primitive_or_ignored`,
/// not here, so user generics like `Pair` keep their own edge.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "predefined_type" => {}
        "identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "qualified_name" => {
            if let Some(s) = node
                .child_by_field_name("name")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            {
                out.push(s.to_string());
            }
        }
        "generic_name" => {
            let mut c = node.walk();
            for ch in node.children(&mut c) {
                if ch.kind() == "type_argument_list" {
                    let mut cc = ch.walk();
                    for arg in ch.children(&mut cc).filter(|a| a.is_named()) {
                        extract_type_leaves(arg, src, out);
                    }
                } else {
                    extract_type_leaves(ch, src, out);
                }
            }
        }
        "nullable_type" | "array_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                extract_type_leaves(ch, src, out);
            }
        }
        _ => {}
    }
}

/// Collect type leaves, de-duped order-preservingly (`Pair<Foo, Foo>` -> one
/// `Foo`).
fn type_leaves(node: TsNode, src: &str) -> Vec<String> {
    let mut raw = Vec::new();
    extract_type_leaves(node, src, &mut raw);
    let mut out = Vec::new();
    for s in raw {
        if !out.contains(&s) {
            out.push(s);
        }
    }
    out
}

/// C# identifier-spelled BCL aliases and stdlib generic containers that should
/// not produce typed edges. (Keyword primitives are `predefined_type` nodes and
/// are skipped in `extract_type_leaves`.) Containers are suppressed so only
/// their inner meaningful type arguments get edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "String"
            | "Object"
            | "Boolean"
            | "Int32"
            | "Int64"
            | "Int16"
            | "Int8"
            | "UInt32"
            | "UInt64"
            | "UInt16"
            | "UInt8"
            | "Single"
            | "Double"
            | "Decimal"
            | "Char"
            | "Byte"
            | "SByte"
            | "Void"
            // Stdlib generic containers.
            | "List"
            | "IList"
            | "IEnumerable"
            | "ICollection"
            | "Dictionary"
            | "IDictionary"
            | "HashSet"
            | "ISet"
            | "Task"
            | "ValueTask"
            | "Nullable"
            | "Span"
            | "ReadOnlySpan"
    )
}

/// Build a method/constructor/local-function `Signature` and emit
/// `has_param` / `returns` edges.
fn csharp_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if p.kind() != "parameter" {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let name = p
                .child_by_field_name("name")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                .unwrap_or("_")
                .to_string();
            if let Some(t) = ty_node {
                for leaf in type_leaves(t, src) {
                    if is_primitive_or_ignored(&leaf) {
                        continue;
                    }
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
                    out.nodes.push(Node {
                        id: format!("extern::{leaf}"),
                        label: leaf.clone(),
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(p)),
                        kind: Some("type".into()),
                        signature: None,
                    });
                }
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    if let Some(ret) = decl.child_by_field_name("returns") {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            let trimmed = text.trim();
            if trimmed != "void" {
                sig.returns = Some(trimmed.to_string());
            }
        }
        for leaf in type_leaves(ret, src) {
            if is_primitive_or_ignored(&leaf) {
                continue;
            }
            out.edges.push(Edge {
                source: fn_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "returns".into(),
                confidence: Confidence::Extracted,
                attr: None,
            });
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(ret)),
                kind: Some("type".into()),
                signature: None,
            });
        }
    }
    sig
}

/// Build a class/struct/record `Signature.fields` and emit `has_field`
/// edges. Returns an empty signature for type decls without a body.
fn csharp_type_signature(
    type_decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = type_decl.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for member in body.children(&mut cursor) {
        match member.kind() {
            "property_declaration" => {
                let Some(ty_node) = member.child_by_field_name("type") else {
                    continue;
                };
                let Some(name) = member
                    .child_by_field_name("name")
                    .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                else {
                    continue;
                };
                emit_field(member, ty_node, name, src, file, type_id, out, &mut sig);
            }
            "field_declaration" => {
                let mut fc = member.walk();
                let Some(var_decl) = member
                    .children(&mut fc)
                    .find(|c| c.kind() == "variable_declaration")
                else {
                    continue;
                };
                let Some(ty_node) = var_decl.child_by_field_name("type") else {
                    continue;
                };
                let mut vc = var_decl.walk();
                let declarators: Vec<TsNode> = var_decl
                    .children(&mut vc)
                    .filter(|c| c.kind() == "variable_declarator")
                    .collect();
                for declarator in declarators {
                    let Some(name) = declarator
                        .child_by_field_name("name")
                        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                    else {
                        continue;
                    };
                    emit_field(member, ty_node, name, src, file, type_id, out, &mut sig);
                }
            }
            _ => {}
        }
    }
    sig
}

/// Push a `FieldSig` and, for non-primitive types, a `has_field` edge plus
/// `extern::<Leaf>` type node.
#[allow(clippy::too_many_arguments)]
fn emit_field(
    loc_node: TsNode,
    ty_node: TsNode,
    name: &str,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
    sig: &mut Signature,
) {
    let ty_text = ty_node
        .utf8_text(src.as_bytes())
        .ok()
        .map(|s| s.trim().to_string());
    for leaf in type_leaves(ty_node, src) {
        if is_primitive_or_ignored(&leaf) {
            continue;
        }
        out.edges.push(Edge {
            source: type_id.to_string(),
            target: format!("extern::{leaf}"),
            relation: "has_field".into(),
            confidence: Confidence::Extracted,
            attr: Some(EdgeAttr {
                name: Some(name.to_string()),
                index: None,
            }),
        });
        out.nodes.push(Node {
            id: format!("extern::{leaf}"),
            label: leaf.clone(),
            source_file: Some(file.to_string()),
            source_location: Some(line_loc(loc_node)),
            kind: Some("type".into()),
            signature: None,
        });
    }
    sig.fields.push(FieldSig {
        name: name.to_string(),
        ty: ty_text,
    });
}

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_c_sharp::LANGUAGE.into())
        .context("load tree-sitter-c-sharp")?;
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
            "method_declaration" | "constructor_declaration" | "local_function_statement" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = csharp_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "method", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "struct_declaration"
            | "record_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = csharp_type_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child,
                    );
                    attach_signature(out, sig);
                }
            }
            "using_directive" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("using")
                    .trim_end_matches(';')
                    .trim();
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
        if matches!(
            child.kind(),
            "method_declaration" | "constructor_declaration" | "local_function_statement"
        ) && let Some(name) = name_of(child, src)
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
        if child.kind() == "invocation_expression"
            && let Some(fn_node) = child.child_by_field_name("function")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
