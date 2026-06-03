//! Go extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

/// Recursively collect leaf type names (including primitives). A `generic_type`
/// pushes its BASE name then recurses each type argument:
/// `Box[Pair[Foo, Bar]]` -> `[Box, Pair, Foo, Bar]`. Pointer / slice / array /
/// qualified wrappers strip or recurse. A `parameter_list` (Go multi-return)
/// descends into each `parameter_declaration`'s type field. Container
/// suppression happens at the emit site via `is_primitive_or_ignored`.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "qualified_type" => {
            if let Ok(s) = node.utf8_text(src.as_bytes())
                && let Some(last) = s.rsplit('.').next()
            {
                out.push(last.to_string());
            }
        }
        "generic_type" => {
            // base type first, then each type argument.
            if let Some(base) = node.child_by_field_name("type") {
                extract_type_leaves(base, src, out);
            }
            if let Some(args) = node.child_by_field_name("type_arguments") {
                let mut c = args.walk();
                for arg in args.children(&mut c).filter(|a| a.is_named()) {
                    extract_type_leaves(arg, src, out);
                }
            }
        }
        "type_elem" | "pointer_type" | "slice_type" | "array_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                extract_type_leaves(ch, src, out);
            }
        }
        "parameter_list" => {
            let mut c = node.walk();
            for decl in node
                .children(&mut c)
                .filter(|ch| ch.kind() == "parameter_declaration")
            {
                if let Some(t) = decl.child_by_field_name("type") {
                    extract_type_leaves(t, src, out);
                }
            }
        }
        _ => {}
    }
}

/// Collect type leaves, de-duped order-preservingly (`Pair[Foo, Foo]` -> one
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

/// Go primitive / builtin types that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "bool"
            | "string"
            | "int"
            | "int8"
            | "int16"
            | "int32"
            | "int64"
            | "uint"
            | "uint8"
            | "uint16"
            | "uint32"
            | "uint64"
            | "uintptr"
            | "byte"
            | "rune"
            | "float32"
            | "float64"
            | "complex64"
            | "complex128"
            | "error"
            | "any"
    )
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges.
fn go_signature(
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
            if p.kind() != "parameter_declaration" {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let leaves = ty_node.map(|t| type_leaves(t, src)).unwrap_or_default();
            // A Go parameter_declaration may bind several names to one type.
            let mut nc = p.walk();
            let mut names: Vec<String> = p
                .children(&mut nc)
                .filter(|c| c.kind() == "identifier")
                .filter_map(|c| c.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()))
                .collect();
            if names.is_empty() {
                names.push("_".to_string());
            }
            for name in names {
                for leaf in &leaves {
                    if is_primitive_or_ignored(leaf) {
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
                sig.params.push(ParamSig {
                    name,
                    ty: ty_text.clone(),
                });
                index += 1;
            }
        }
    }
    if let Some(ret) = decl.child_by_field_name("result") {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            sig.returns = Some(text.trim().to_string());
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

/// Build a struct `Signature.fields` and emit `has_field` edges. Returns an
/// empty signature for non-struct type specs (interfaces, aliases).
fn go_struct_signature(
    type_spec: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(ty) = type_spec.child_by_field_name("type") else {
        return sig;
    };
    if ty.kind() != "struct_type" {
        return sig;
    }
    let mut tc = ty.walk();
    let Some(fdl) = ty
        .children(&mut tc)
        .find(|c| c.kind() == "field_declaration_list")
    else {
        return sig;
    };
    let mut cursor = fdl.walk();
    for field in fdl.children(&mut cursor) {
        if field.kind() != "field_declaration" {
            continue;
        }
        let mut fc = field.walk();
        let names: Vec<String> = field
            .children(&mut fc)
            .filter(|c| c.kind() == "field_identifier")
            .filter_map(|c| c.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()))
            .collect();
        if names.is_empty() {
            continue; // embedded field (no name)
        }
        let ty_node = field.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        let leaves = ty_node.map(|t| type_leaves(t, src)).unwrap_or_default();
        for name in names {
            for leaf in &leaves {
                if is_primitive_or_ignored(leaf) {
                    continue;
                }
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
                    source_location: Some(line_loc(field)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            sig.fields.push(FieldSig {
                name,
                ty: ty_text.clone(),
            });
        }
    }
    sig
}

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_go::LANGUAGE.into())
        .context("load tree-sitter-go")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    walk_defs(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
}

fn walk_defs(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_declaration" | "method_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = go_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    attach_signature(out, sig);
                }
            }
            "type_spec" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = go_struct_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "type", n, child);
                    attach_signature(out, sig);
                }
            }
            "import_spec" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("import_spec has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches('"');
                emit_import(out, file, trimmed, child);
            }
            _ => {}
        }
        walk_defs(child, src, file, out, symbols);
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
        if matches!(child.kind(), "function_declaration" | "method_declaration")
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
        if child.kind() == "call_expression" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call_expression has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
