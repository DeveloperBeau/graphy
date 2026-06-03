//! Swift extractor.
//!
//! tree-sitter-swift surfaces declaration names through `simple_identifier`
//! (functions, properties) and `type_identifier` (classes/structs/enums/
//! protocols/actors), rather than via a `name` field. We walk the direct
//! children of each declaration looking for those kinds.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_swift::LANGUAGE.into())
        .context("load tree-sitter-swift")?;
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

fn swift_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(c.kind(), "simple_identifier" | "type_identifier") {
            return c.utf8_text(src.as_bytes()).ok();
        }
    }
    None
}

/// The tree-sitter-swift grammar uses `class_declaration` for struct/enum/class/actor.
/// The actual keyword child distinguishes them: `struct`, `enum`, `class`, `actor`.
fn classify_swift(node: tree_sitter::Node, src: &str) -> Option<&'static str> {
    match node.kind() {
        "function_declaration"
        | "init_declaration"
        | "deinit_declaration"
        | "protocol_function_declaration" => return Some("function"),
        "protocol_declaration" => return Some("protocol"),
        "class_declaration" => {
            // Distinguish struct / enum / class / actor by first unnamed keyword child.
            let mut cursor = node.walk();
            for c in node.children(&mut cursor) {
                if !c.is_named() {
                    match c.utf8_text(src.as_bytes()).unwrap_or("") {
                        "struct" => return Some("struct"),
                        "enum" => return Some("enum"),
                        "actor" => return Some("class"),
                        _ => return Some("class"),
                    }
                }
            }
            return Some("class");
        }
        _ => {}
    }
    None
}

/// Synthetic name for declaration kinds whose name is a fixed keyword rather
/// than an identifier node. Returns Some("init") / Some("deinit") for the
/// corresponding declaration nodes; None for all others.
fn synthetic_name(node: TsNode) -> Option<&'static str> {
    match node.kind() {
        "init_declaration" => Some("init"),
        "deinit_declaration" => Some("deinit"),
        _ => None,
    }
}

/// Extract the leaf type name from a Swift type node. Returns `None` for
/// nodes that carry no nameable type (function types, tuples, etc.).
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "type_identifier" => node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()),
        "user_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find(|ch| ch.kind() == "type_identifier")
                .and_then(|t| extract_type_leaf(t, src))
        }
        "optional_type" => node
            .child_by_field_name("wrapped")
            .and_then(|w| extract_type_leaf(w, src)),
        "array_type" | "dictionary_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
        _ => None,
    }
}

/// Swift primitive / builtin types that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "Int"
            | "Int8"
            | "Int16"
            | "Int32"
            | "Int64"
            | "UInt"
            | "UInt8"
            | "UInt16"
            | "UInt32"
            | "UInt64"
            | "Float"
            | "Float32"
            | "Float64"
            | "Double"
            | "Bool"
            | "String"
            | "Character"
            | "Void"
    )
}

/// First type-kinded direct child of `node` (param type or return type). In a
/// `function_declaration` and a `parameter`, the type node sits alongside the
/// overloaded `name:` identifier, so it must be located by kind, not field.
fn first_type_child(node: TsNode) -> Option<TsNode> {
    let mut c = node.walk();
    node.children(&mut c).find(|ch| {
        matches!(
            ch.kind(),
            "user_type" | "optional_type" | "array_type" | "dictionary_type"
        )
    })
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges.
fn swift_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let mut cursor = decl.walk();
    let mut index: u32 = 0;
    for child in decl.children(&mut cursor) {
        if child.kind() != "parameter" {
            continue;
        }
        let name = child
            .child_by_field_name("name")
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            .unwrap_or("_")
            .to_string();
        let ty_node = first_type_child(child);
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        let leaf = ty_node
            .and_then(|t| extract_type_leaf(t, src))
            .filter(|l| !is_primitive_or_ignored(l));
        if let Some(leaf) = &leaf {
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
                source_location: Some(line_loc(child)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.params.push(ParamSig { name, ty: ty_text });
        index += 1;
    }
    // Return type is the type-kinded direct child of the declaration (params'
    // types are nested inside `parameter` nodes, so this picks the return).
    if let Some(ret) = first_type_child(decl) {
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

/// Build a struct/class `Signature.fields` from stored properties and emit
/// `has_field` edges.
fn swift_type_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = decl.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for prop in body.children(&mut cursor) {
        if prop.kind() != "property_declaration" {
            continue;
        }
        let Some(name) = prop
            .child_by_field_name("name")
            .and_then(|p| p.child_by_field_name("bound_identifier"))
            .and_then(|i| i.utf8_text(src.as_bytes()).ok())
            .map(|s| s.to_string())
        else {
            continue;
        };
        let mut pc = prop.walk();
        let ty_node = prop
            .children(&mut pc)
            .find(|c| c.kind() == "type_annotation")
            .and_then(|ann| ann.child_by_field_name("name"));
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
                source_location: Some(line_loc(prop)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
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
        // Compute the typed signature BEFORE emit_def so attach_signature binds
        // to the def node (which emit_def pushes last). Preserves the existing
        // classify_swift dispatch unchanged.
        let sig: Option<Signature> = match child.kind() {
            "function_declaration" => swift_name(child, src)
                .or_else(|| synthetic_name(child))
                .map(|n| {
                    let id = format!("{file}::{n}");
                    swift_signature(child, src, file, &id, out)
                }),
            "class_declaration" => swift_name(child, src).map(|n| {
                let id = format!("{file}::{n}");
                swift_type_signature(child, src, file, &id, out)
            }),
            _ => None,
        };

        if let Some(kind) = classify_swift(child, src) {
            // init/deinit have no identifier child; use the fixed keyword label.
            let name = swift_name(child, src).or_else(|| synthetic_name(child));
            if let Some(n) = name {
                emit_def(out, symbols, file, kind, n, child);
                if let Some(s) = sig {
                    attach_signature(out, s);
                }
            }
        }
        if child.kind() == "import_declaration"
            && let Some(first) = child.named_child(0)
        {
            let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_import(out, file, text, child);
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
            "function_declaration" | "init_declaration" | "deinit_declaration"
        ) {
            let name = swift_name(child, src)
                .or_else(|| synthetic_name(child))
                .unwrap_or("<anon>");
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
