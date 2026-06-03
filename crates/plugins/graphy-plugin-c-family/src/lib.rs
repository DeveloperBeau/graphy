//! C / C++ language plugin for graphy.
//!
//! The C++ tree-sitter grammar is a superset of C; we dispatch based on the
//! file extension and use the matching grammar.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
use tree_sitter::{Language, Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-c-family",
    extensions: ["c", "h", "cpp", "cc", "cxx", "hpp"],
    extract_json: extract_to_json,
}

#[derive(Copy, Clone)]
enum Flavor {
    C,
    Cpp,
}

fn flavor_for(path: &str) -> Flavor {
    let lower = path.to_ascii_lowercase();
    if lower.ends_with(".cpp")
        || lower.ends_with(".cc")
        || lower.ends_with(".cxx")
        || lower.ends_with(".hpp")
    {
        Flavor::Cpp
    } else {
        Flavor::C
    }
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let flavor = flavor_for(path);
    let lang: Language = match flavor {
        Flavor::C => tree_sitter_c::LANGUAGE.into(),
        Flavor::Cpp => tree_sitter_cpp::LANGUAGE.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .map_err(|e| format!("load tree-sitter-c/cpp: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    let cpp = matches!(flavor, Flavor::Cpp);
    walk(tree.root_node(), source, path, &mut out, &mut symbols, cpp);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

/// Extract the leaf type name from a C++ type node. Returns `None` for
/// primitives (kind `primitive_type`) and anything not a named type.
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        "type_identifier" => node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()),
        _ => None,
    }
}

/// C++ primitive / builtin types that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "void"
            | "bool"
            | "int"
            | "unsigned"
            | "long"
            | "short"
            | "char"
            | "float"
            | "double"
            | "auto"
            | "size_t"
            | "uint8_t"
            | "uint16_t"
            | "uint32_t"
            | "uint64_t"
            | "int8_t"
            | "int16_t"
            | "int32_t"
            | "int64_t"
    )
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges
/// for a C++ `function_definition`. Pure Option handling throughout so
/// constructors / destructors (no `type` field) never panic.
fn cpp_signature(
    fn_def: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();
    let params = fn_def
        .child_by_field_name("declarator")
        .filter(|d| d.kind() == "function_declarator")
        .and_then(|d| d.child_by_field_name("parameters"));
    if let Some(params) = params {
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
            let leaf = ty_node
                .and_then(|t| extract_type_leaf(t, src))
                .filter(|l| !is_primitive_or_ignored(l));
            let name = p
                .child_by_field_name("declarator")
                .and_then(|d| d.utf8_text(src.as_bytes()).ok())
                .map(|s| s.to_string())
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
    if let Some(ret) = fn_def.child_by_field_name("type") {
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

/// Build a `Signature.fields` for a C++ `struct_specifier` / `class_specifier`
/// and emit `has_field` edges. Skips method prototypes and embedded fields.
fn cpp_field_signature(
    specifier: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = specifier.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for field in body.children(&mut cursor) {
        if field.kind() != "field_declaration" {
            continue;
        }
        let Some(decl) = field.child_by_field_name("declarator") else {
            continue;
        };
        if decl.kind() == "function_declarator" {
            continue;
        }
        let mut cur = decl;
        let mut name: Option<String> = None;
        for _ in 0..6 {
            if cur.kind() == "field_identifier" {
                name = cur.utf8_text(src.as_bytes()).ok().map(|s| s.to_string());
                break;
            }
            match cur.child_by_field_name("declarator") {
                Some(next) => cur = next,
                None => break,
            }
        }
        let Some(name) = name else {
            continue;
        };
        let ty_node = field.child_by_field_name("type");
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
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(field.start_position().row)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    // function_definition / declaration → declarator → function_declarator
    // → identifier. Bound the descent at 6 steps so a pathological grammar
    // can never spin forever.
    let mut cur = node;
    for _ in 0..6 {
        let next = cur
            .child_by_field_name("declarator")
            .or_else(|| cur.child_by_field_name("name"))?;
        if next.kind() == "identifier" || next.kind() == "field_identifier" {
            return next.utf8_text(src.as_bytes()).ok();
        }
        cur = next;
    }
    None
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
    cpp: bool,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
                    if cpp {
                        let id = format!("{file}::{n}");
                        let sig = cpp_signature(child, src, file, &id, out);
                        emit_def(
                            out,
                            symbols,
                            file,
                            "function",
                            n,
                            child.start_position().row,
                        );
                        attach_signature(out, sig);
                    } else {
                        emit_def(
                            out,
                            symbols,
                            file,
                            "function",
                            n,
                            child.start_position().row,
                        );
                    }
                }
            }
            "struct_specifier" | "class_specifier" if cpp => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = cpp_field_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child.start_position().row,
                    );
                    attach_signature(out, sig);
                }
            }
            "struct_specifier" | "class_specifier" | "union_specifier" | "enum_specifier" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "preproc_include" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("preproc_include has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                emit_import(out, file, trimmed, child.start_position().row);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols, cpp);
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
        if child.kind() == "function_definition"
            && let Some(name) = declarator_name(child, src)
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
            && let Some(fn_node) = child.child_by_field_name("function")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract_cpp(src: &str) -> Value {
        let bytes = extract_to_json("s.cpp", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn cpp_emits_typed_edges_and_signature_payload() {
        let v = extract_cpp(
            "struct Widget { int count; Widget* next; };\n\
             Widget order(int n, Widget w) { return w; }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.cpp::order")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 1); // counts the primitive n

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.cpp::order")
        );
        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.cpp::Widget"
            && e["attr"]["name"] == "next"));
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let order = nodes.iter().find(|n| n["id"] == "s.cpp::order").unwrap();
        assert_eq!(order["signature"]["returns"], "Widget");
        assert_eq!(order["signature"]["params"].as_array().unwrap().len(), 2);
    }

    #[test]
    fn c_flavor_emits_no_signature() {
        // Plain C must be unaffected: no typed edges, no signature payload.
        let bytes =
            extract_to_json("s.c", "struct W { int x; };\nint f(int n) { return n; }\n").unwrap();
        let v: Value = serde_json::from_slice(&bytes).unwrap();
        let edges = v["edges"].as_array().unwrap();
        assert!(
            !edges
                .iter()
                .any(|e| e["relation"] == "has_param" || e["relation"] == "has_field"),
            "C flavor emitted typed edges: {edges:#?}"
        );
        let f = v["nodes"]
            .as_array()
            .unwrap()
            .iter()
            .find(|n| n["id"] == "s.c::f")
            .unwrap();
        assert!(f.get("signature").is_none() || f["signature"].is_null());
    }
}
