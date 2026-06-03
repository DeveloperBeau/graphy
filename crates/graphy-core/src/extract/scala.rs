//! Scala extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{
    attach_signature, emit_call, emit_def, emit_import, emit_inherits, line_loc, name_of,
};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

/// Extract the leaf type name from a Scala type node.
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "type_identifier" => node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()),
        "stable_type_identifier" => node
            .utf8_text(src.as_bytes())
            .ok()
            .and_then(|s| s.rsplit('.').next().map(|x| x.to_string())),
        "generic_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
        _ => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
    }
}

/// Scala primitive / builtin types that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "Int"
            | "Long"
            | "Short"
            | "Byte"
            | "Double"
            | "Float"
            | "Boolean"
            | "Char"
            | "Unit"
            | "Any"
            | "AnyRef"
            | "AnyVal"
            | "Nothing"
            | "Null"
            | "String"
    )
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges.
///
/// Only the first `parameters` node is processed; curried definitions
/// (`def f(a: Int)(b: Widget)`) contribute only their first parameter list.
fn scala_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl
        .child_by_field_name("parameters")
        .filter(|p| p.kind() == "parameters")
    {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if p.kind() != "parameter" {
                continue;
            }
            let name = p
                .child_by_field_name("name")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                .unwrap_or("_")
                .to_string();
            let ty_node = p.child_by_field_name("type");
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
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(p)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    if let Some(ret) = decl.child_by_field_name("return_type") {
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

/// Build a class `Signature.fields` from constructor `class_parameters` and
/// emit `has_field` edges.
fn scala_class_signature(
    class_def: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(params) = class_def.child_by_field_name("class_parameters") else {
        return sig;
    };
    let mut cursor = params.walk();
    for p in params.children(&mut cursor) {
        if p.kind() != "class_parameter" {
            continue;
        }
        let name = match p
            .child_by_field_name("name")
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
        {
            Some(n) => n.to_string(),
            None => continue,
        };
        let ty_node = p.child_by_field_name("type");
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
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(p)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_scala::LANGUAGE.into())
        .context("load tree-sitter-scala")?;
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
            "function_definition" | "function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = scala_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_definition" | "object_definition" | "trait_definition" => {
                if let Some(n) = name_of(child, src) {
                    let child_id = format!("{file}::{n}");
                    // class_definition carries constructor params; objects/traits do not.
                    let sig = if child.kind() == "class_definition" {
                        Some(scala_class_signature(child, src, file, &child_id, out))
                    } else {
                        None
                    };
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_definition"),
                        n,
                        child,
                    );
                    if let Some(sig) = sig {
                        attach_signature(out, sig);
                    }
                    // Emit inherits edges for extends/with clause (after attach_signature).
                    let mut ec = child.walk();
                    for grandchild in child.children(&mut ec) {
                        if grandchild.kind() == "extends_clause" {
                            let mut gc = grandchild.walk();
                            for item in grandchild.children(&mut gc) {
                                if item.kind() == "type_identifier"
                                    && let Ok(parent) = item.utf8_text(src.as_bytes())
                                {
                                    emit_inherits(out, &child_id, parent, "inherits", item);
                                }
                            }
                        }
                    }
                }
            }
            "import_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text.trim_start_matches("import").trim();
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
        if matches!(child.kind(), "function_definition" | "function_declaration")
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
