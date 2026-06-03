//! PHP language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-php",
    extensions: ["php"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_php::LANGUAGE_PHP.into())
        .map_err(|e| format!("load tree-sitter-php: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
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
        match child.kind() {
            "function_definition" | "method_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = php_signature(child, src, file, &id, out);
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
            "class_declaration"
            | "interface_declaration"
            | "trait_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = php_class_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child.start_position().row,
                    );
                    attach_signature(out, sig);
                }
            }
            "namespace_use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text.trim_start_matches("use").trim_end_matches(';').trim();
                emit_import(out, file, target, child.start_position().row);
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
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if matches!(child.kind(), "function_definition" | "method_declaration")
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
        if matches!(
            child.kind(),
            "function_call_expression" | "member_call_expression" | "scoped_call_expression"
        ) && let Some(fn_node) = child
            .child_by_field_name("function")
            .or_else(|| child.child_by_field_name("name"))
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "int"
            | "string"
            | "float"
            | "bool"
            | "void"
            | "mixed"
            | "array"
            | "object"
            | "callable"
            | "iterable"
            | "null"
            | "never"
            | "false"
            | "true"
            | "self"
            | "static"
            | "parent"
    )
}

fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "primitive_type" => None,
        "optional_type" | "named_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
        "name" => node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()),
        "qualified_name" => node
            .utf8_text(src.as_bytes())
            .ok()
            .and_then(|s| s.rsplit('\\').next().map(|x| x.to_string())),
        _ => None,
    }
}

fn param_name(node: TsNode, src: &str) -> Option<String> {
    node.utf8_text(src.as_bytes())
        .ok()
        .map(|s| s.trim_start_matches('$').to_string())
}

fn php_signature(decl: TsNode, src: &str, file: &str, fn_id: &str, out: &mut Output) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if !matches!(
                p.kind(),
                "simple_parameter" | "variadic_parameter" | "property_promotion_parameter"
            ) {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let leaf = ty_node
                .and_then(|t| extract_type_leaf(t, src))
                .filter(|l| !is_primitive_or_ignored(l));
            let name = p
                .child_by_field_name("name")
                .and_then(|n| param_name(n, src))
                .unwrap_or_else(|| "_".to_string());
            if let Some(ref leaf) = leaf {
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

fn php_class_signature(
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
    for member in body.children(&mut cursor) {
        if member.kind() != "property_declaration" {
            continue;
        }
        let ty_node = member.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        let leaf = ty_node
            .and_then(|t| extract_type_leaf(t, src))
            .filter(|l| !is_primitive_or_ignored(l));
        let mut pc = member.walk();
        let Some(name) = member
            .children(&mut pc)
            .find(|c| c.kind() == "property_element")
            .and_then(|el| el.child_by_field_name("name"))
            .and_then(|n| param_name(n, src))
        else {
            continue;
        };
        if let Some(leaf) = &leaf {
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
                source_location: Some(line_loc(member.start_position().row)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.php", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "<?php\n\
             class Box { public Widget $item; public int $count; }\n\
             function build(int $n, Widget $w): Widget { return $w; }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.php::build")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.php::build")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.php::Box"
            && e["attr"]["name"] == "item"));
        // primitive param emits no has_param edge
        assert!(
            !edges
                .iter()
                .any(|e| e["relation"] == "has_param" && e["attr"]["name"] == "n")
        );
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let build = nodes.iter().find(|n| n["id"] == "s.php::build").unwrap();
        assert_eq!(build["signature"]["returns"], "Widget");
        assert_eq!(build["signature"]["params"].as_array().unwrap().len(), 2);
    }
}
