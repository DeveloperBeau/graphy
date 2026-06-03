//! Kotlin language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-kotlin",
    extensions: ["kt", "kts"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_kotlin_ng::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-kotlin-ng: {e}"))?;
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
            "function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = kotlin_fn_signature(child, src, file, &id, out);
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
            "class_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = kotlin_class_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "class", n, child.start_position().row);
                    attach_signature(out, sig);
                }
            }
            "object_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "object", n, child.start_position().row);
                }
            }
            "import_header" | "import_directive" | "import" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("import")
                    .trim()
                    .trim_end_matches(';');
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

fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "user_type" => {
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

fn first_type_child(parent: TsNode) -> Option<TsNode> {
    let mut c = parent.walk();
    parent
        .children(&mut c)
        .find(|ch| matches!(ch.kind(), "user_type" | "nullable_type"))
}

fn first_identifier(parent: TsNode, src: &str) -> Option<String> {
    let mut c = parent.walk();
    parent
        .children(&mut c)
        .find(|ch| ch.kind() == "identifier")
        .and_then(|ch| ch.utf8_text(src.as_bytes()).ok())
        .map(|s| s.to_string())
}

fn push_type_node(out: &mut Output, file: &str, leaf: &str, row: usize) {
    out.nodes.push(Node {
        id: format!("extern::{leaf}"),
        label: leaf.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(row)),
        kind: Some("type".into()),
        signature: None,
    });
}

fn kotlin_fn_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
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
                    confidence: EXTRACTED,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                push_type_node(out, file, leaf, p.start_position().row);
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
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
                confidence: EXTRACTED,
                attr: None,
            });
            push_type_node(out, file, &leaf, ret.start_position().row);
        }
    }
    sig
}

#[allow(clippy::too_many_arguments)]
fn emit_field(
    out: &mut Output,
    sig: &mut Signature,
    file: &str,
    type_id: &str,
    name: String,
    ty_node: Option<TsNode>,
    loc_row: usize,
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
            confidence: EXTRACTED,
            attr: Some(EdgeAttr {
                name: Some(name.clone()),
                index: None,
            }),
        });
        push_type_node(out, file, leaf, loc_row);
    }
    sig.fields.push(FieldSig { name, ty: ty_text });
}

fn kotlin_class_signature(
    class_decl: TsNode,
    src: &str,
    file: &str,
    class_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();

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
                        param.start_position().row,
                        src,
                    );
                }
            }
        }
    }

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
                    prop.start_position().row,
                    src,
                );
            }
        }
    }

    sig
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.kt", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "package p\n\
             data class Widget(val label: String, val owner: Widget?)\n\
             fun order(n: Int, widget: Widget): Widget { return widget }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.kt::order")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "widget");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.kt::order")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.kt::Widget"
            && e["attr"]["name"] == "owner"));
        // label is String (primitive) -> no has_field
        assert!(
            !edges
                .iter()
                .any(|e| e["relation"] == "has_field" && e["attr"]["name"] == "label")
        );
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let order = nodes.iter().find(|n| n["id"] == "s.kt::order").unwrap();
        assert_eq!(order["signature"]["returns"], "Widget");
        assert_eq!(order["signature"]["params"].as_array().unwrap().len(), 2);
    }
}
