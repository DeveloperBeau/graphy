//! Go language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-go",
    extensions: ["go"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_go::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-go: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk_defs(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn walk_defs(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_declaration" | "method_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = go_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        "function",
                        n,
                        child.start_position().row,
                    );
                    attach_signature(out, sig);
                }
            }
            "type_spec" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = go_struct_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "type", n, child.start_position().row);
                    attach_signature(out, sig);
                }
            }
            "import_spec" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("import_spec has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches('"');
                emit_import(out, file, trimmed, child.start_position().row);
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
    out: &mut Output,
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
    out: &mut Output,
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

fn go_signature(decl: TsNode, src: &str, file: &str, fn_id: &str, out: &mut Output) -> Signature {
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
                        source_location: Some(line_loc(p.start_position().row)),
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

fn go_struct_signature(
    type_spec: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
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
            continue;
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
                    source_location: Some(line_loc(field.start_position().row)),
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

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.go", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "package p\n\
             type Widget struct { W Widget; Label string }\n\
             func Order(n int, w Widget) Widget { return w }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.go::Order")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.go::Order")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.go::Widget"
            && e["attr"]["name"] == "W"));
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let order = nodes.iter().find(|n| n["id"] == "s.go::Order").unwrap();
        assert_eq!(order["signature"]["returns"], "Widget");
        assert_eq!(order["signature"]["params"].as_array().unwrap().len(), 2);
    }

    #[test]
    fn generic_param_emits_container_and_inner_edges() {
        let v = extract("package p\nfunc collect(b Box[Widget]) {}\n");
        let edges = v["edges"].as_array().unwrap();

        // Box[Widget] -> edges to BOTH the container base and the inner type,
        // both carrying param name "b" / index 0.
        for target in ["extern::Box", "extern::Widget"] {
            let e = edges
                .iter()
                .find(|e| {
                    e["relation"] == "has_param"
                        && e["source"] == "s.go::collect"
                        && e["target"] == target
                })
                .unwrap_or_else(|| panic!("missing {target} edge in {edges:#?}"));
            assert_eq!(e["attr"]["name"], "b");
            assert_eq!(e["attr"]["index"], 0);
        }

        // Payload keeps the full generic text.
        let nodes = v["nodes"].as_array().unwrap();
        let collect = nodes.iter().find(|n| n["id"] == "s.go::collect").unwrap();
        assert_eq!(collect["signature"]["params"][0]["ty"], "Box[Widget]");
    }
}
