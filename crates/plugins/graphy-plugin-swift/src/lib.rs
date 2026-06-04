//! Swift language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-swift",
    extensions: ["swift"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_swift::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-swift: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
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
fn classify(node: TsNode, src: &str) -> Option<&'static str> {
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

/// Recursively collect leaf type names (including primitives and stdlib
/// containers). A `user_type` pushes its BASE name then recurses into each
/// named type argument: `Array<Pair<Foo, Bar>>` -> `[Array, Pair, Foo, Bar]`.
/// The sugar forms (`array_type`, `dictionary_type`, `optional_type`) carry no
/// base name, so they recurse straight into their inner types. Container
/// suppression happens at the emit site via `is_primitive_or_ignored`, not
/// here, so user generics like `Pair` keep their own edge.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "user_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c) {
                match ch.kind() {
                    "type_identifier" => extract_type_leaves(ch, src, out),
                    "type_arguments" => {
                        let mut ac = ch.walk();
                        for arg in ch.children(&mut ac).filter(|a| a.is_named()) {
                            extract_type_leaves(arg, src, out);
                        }
                    }
                    _ => {}
                }
            }
        }
        "optional_type" => {
            if let Some(w) = node.child_by_field_name("wrapped") {
                extract_type_leaves(w, src, out);
            }
        }
        "array_type" | "dictionary_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|a| a.is_named()) {
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
            // Stdlib generic containers (explicit-generic spelling).
            | "Array"
            | "Optional"
            | "Dictionary"
            | "Set"
    )
}

fn first_type_child(node: TsNode) -> Option<TsNode> {
    let mut c = node.walk();
    node.children(&mut c).find(|ch| {
        matches!(
            ch.kind(),
            "user_type" | "optional_type" | "array_type" | "dictionary_type"
        )
    })
}

fn swift_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
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
        if let Some(t) = ty_node {
            for leaf in type_leaves(t, src) {
                if is_primitive_or_ignored(&leaf) {
                    continue;
                }
                out.edges.push(Edge {
                    source: fn_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_param".into(),
                    confidence: EXTRACTED,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(child.start_position().row)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
        }
        sig.params.push(ParamSig { name, ty: ty_text });
        index += 1;
    }
    if let Some(ret) = first_type_child(decl) {
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
                confidence: EXTRACTED,
                attr: None,
            });
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(ret.start_position().row)),
                kind: Some("type".into()),
                signature: None,
            });
        }
    }
    sig
}

fn swift_type_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
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
        if let Some(t) = ty_node {
            for leaf in type_leaves(t, src) {
                if is_primitive_or_ignored(&leaf) {
                    continue;
                }
                out.edges.push(Edge {
                    source: type_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_field".into(),
                    confidence: EXTRACTED,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: None,
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(prop.start_position().row)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        // Compute the typed signature BEFORE emit_def so attach_signature binds
        // to the def node (pushed last). Preserves the existing classify gate.
        let sig: Option<Signature> = match child.kind() {
            "function_declaration" => swift_name(child, src).map(|n| {
                let id = format!("{file}::{n}");
                swift_signature(child, src, file, &id, out)
            }),
            "class_declaration" => swift_name(child, src).map(|n| {
                let id = format!("{file}::{n}");
                swift_type_signature(child, src, file, &id, out)
            }),
            _ => None,
        };

        if let Some(kind) = classify(child, src)
            && let Some(n) = swift_name(child, src)
        {
            emit_def(out, symbols, file, kind, n, child.start_position().row);
            if let Some(s) = sig {
                attach_signature(out, s);
            }
        }
        if child.kind() == "import_declaration"
            && let Some(first) = child.named_child(0)
        {
            let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_import(out, file, text, child.start_position().row);
        }
        walk(child, src, file, out, symbols);
    }
}

fn walk_calls(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if matches!(
            child.kind(),
            "function_declaration" | "init_declaration" | "deinit_declaration"
        ) {
            let name = swift_name(child, src).unwrap_or("<anon>");
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
    out: &mut Output,
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

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.swift", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "struct Widget { var w: Widget }\n\
             func order(n: Int, w: Widget) -> Widget { return w }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.swift::order")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.swift::order")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.swift::Widget"
            && e["attr"]["name"] == "w"));
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let order = nodes.iter().find(|n| n["id"] == "s.swift::order").unwrap();
        assert_eq!(order["signature"]["returns"], "Widget");
        assert_eq!(order["signature"]["params"].as_array().unwrap().len(), 2);
    }
}
