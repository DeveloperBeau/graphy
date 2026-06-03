//! C# language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-csharp",
    extensions: ["cs"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_c_sharp::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-c-sharp: {e}"))?;
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
            "method_declaration" | "constructor_declaration" | "local_function_statement" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = csharp_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
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
                        child.start_position().row,
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
    out: &mut Output,
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

fn csharp_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
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

fn csharp_type_signature(
    type_decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
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

#[allow(clippy::too_many_arguments)]
fn emit_field(
    loc_node: TsNode,
    ty_node: TsNode,
    name: &str,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
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
            confidence: EXTRACTED,
            attr: Some(EdgeAttr {
                name: Some(name.to_string()),
                index: None,
            }),
        });
        out.nodes.push(Node {
            id: format!("extern::{leaf}"),
            label: leaf.clone(),
            source_file: Some(file.to_string()),
            source_location: Some(line_loc(loc_node.start_position().row)),
            kind: Some("type".into()),
            signature: None,
        });
    }
    sig.fields.push(FieldSig {
        name: name.to_string(),
        ty: ty_text,
    });
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.cs", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "public class Widget { public Widget Inner { get; set; } public string Label { get; set; } }\n\
             public static class F { public static Widget Order(int n, Widget w) { return w; } }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.cs::Order")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.cs::Order")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.cs::Widget"
            && e["attr"]["name"] == "Inner"));
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let order = nodes.iter().find(|n| n["id"] == "s.cs::Order").unwrap();
        assert_eq!(order["signature"]["returns"], "Widget");
        assert_eq!(order["signature"]["params"].as_array().unwrap().len(), 2);
    }

    #[test]
    fn emits_generic_inner_type_edges() {
        let v = extract("public class C { public void M(List<Widget> a, Pair<Foo, Bar> b) {} }\n");
        let edges = v["edges"].as_array().unwrap();
        let hp: Vec<&Value> = edges
            .iter()
            .filter(|e| e["relation"] == "has_param" && e["source"] == "s.cs::M")
            .collect();
        let targets: Vec<&str> = hp.iter().map(|e| e["target"].as_str().unwrap()).collect();

        // List container suppressed; inner Widget kept.
        assert!(targets.contains(&"extern::Widget"), "targets = {targets:?}");
        assert!(!targets.contains(&"extern::List"), "targets = {targets:?}");
        // Pair (user generic) plus both inner args.
        assert!(targets.contains(&"extern::Pair"), "targets = {targets:?}");
        assert!(targets.contains(&"extern::Foo"), "targets = {targets:?}");
        assert!(targets.contains(&"extern::Bar"), "targets = {targets:?}");

        // Widget shares index 0 (param a); Pair/Foo/Bar share index 1 (param b).
        let widget = hp.iter().find(|e| e["target"] == "extern::Widget").unwrap();
        assert_eq!(widget["attr"]["index"], 0);
        for t in ["extern::Pair", "extern::Foo", "extern::Bar"] {
            let e = hp.iter().find(|e| e["target"] == t).unwrap();
            assert_eq!(e["attr"]["index"], 1, "edge {t}");
        }

        // Payload `ty` keeps the full textual generic type.
        let m = v["nodes"]
            .as_array()
            .unwrap()
            .iter()
            .find(|n| n["id"] == "s.cs::M")
            .unwrap();
        let params = m["signature"]["params"].as_array().unwrap();
        assert_eq!(params[0]["ty"], "List<Widget>");
        assert_eq!(params[1]["ty"], "Pair<Foo, Bar>");
    }
}
