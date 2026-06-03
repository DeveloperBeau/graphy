//! Rust language plugin for graphy.

use std::collections::HashMap;

use serde::Serialize;
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-rust",
    extensions: ["rs"],
    extract_json: extract_to_json,
}

#[derive(Serialize, Default)]
struct Output {
    nodes: Vec<Node>,
    edges: Vec<Edge>,
}

#[derive(Serialize)]
struct Node {
    id: String,
    label: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    source_file: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    source_location: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    kind: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    signature: Option<Signature>,
}

#[derive(Serialize)]
struct Edge {
    source: String,
    target: String,
    relation: String,
    confidence: &'static str,
    #[serde(skip_serializing_if = "Option::is_none")]
    attr: Option<EdgeAttr>,
}

#[derive(Serialize, Default)]
struct Signature {
    #[serde(skip_serializing_if = "Vec::is_empty")]
    params: Vec<ParamSig>,
    #[serde(skip_serializing_if = "Option::is_none")]
    returns: Option<String>,
    #[serde(skip_serializing_if = "Vec::is_empty")]
    fields: Vec<FieldSig>,
}

#[derive(Serialize)]
struct ParamSig {
    name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    ty: Option<String>,
}

#[derive(Serialize)]
struct FieldSig {
    name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    ty: Option<String>,
}

#[derive(Serialize)]
struct EdgeAttr {
    #[serde(skip_serializing_if = "Option::is_none")]
    name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    index: Option<u32>,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rust::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-rust: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk_items(tree.root_node(), source, path, &mut out, &mut symbols);
    add_call_edges(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn line_loc(node: TsNode) -> String {
    format!("L{}", node.start_position().row + 1)
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn walk_items(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let kind = child.kind();
        match kind {
            "function_item" | "struct_item" | "enum_item" | "trait_item" | "mod_item"
            | "impl_item" => {
                if let Some(name) = name_of(child, src) {
                    let id = format!("{file}::{name}");
                    symbols.insert(name.to_string(), id.clone());
                    let signature = if kind == "function_item" {
                        Some(function_signature(child, src, file, &id, out))
                    } else if kind == "struct_item" {
                        Some(struct_signature(child, src, file, &id, out))
                    } else {
                        None
                    };
                    out.nodes.push(Node {
                        id,
                        label: name.to_string(),
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(child)),
                        kind: Some(kind.trim_end_matches("_item").to_string()),
                        signature,
                    });
                }
            }
            "use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text.trim_start_matches("use ").trim_end_matches(';').trim();
                for path in expand_import_paths(cleaned) {
                    let target = path.trim().to_string();
                    if !target.is_empty() {
                        let import_id = format!("extern::{target}");
                        out.nodes.push(Node {
                            id: import_id.clone(),
                            label: target,
                            source_file: Some(file.to_string()),
                            source_location: Some(line_loc(child)),
                            kind: Some("import".into()),
                            signature: None,
                        });
                        out.edges.push(Edge {
                            source: file.to_string(),
                            target: import_id,
                            relation: "imports".into(),
                            confidence: "EXTRACTED",
                            attr: None,
                        });
                    }
                }
            }
            _ => {}
        }
        walk_items(child, src, file, out, symbols);
    }
}

fn add_call_edges(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_item"
            && let Some(name) = name_of(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls_in(child, src, &caller_id, out, symbols);
        }
        add_call_edges(child, src, file, out, symbols);
    }
}

fn collect_calls_in(
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
            let callee = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            let leaf = callee.rsplit("::").next().unwrap_or(callee);
            if let Some(target_id) = symbols.get(leaf) {
                out.edges.push(Edge {
                    source: caller_id.to_string(),
                    target: target_id.clone(),
                    relation: "calls".into(),
                    confidence: "INFERRED",
                    attr: None,
                });
            }
        }
        collect_calls_in(child, src, caller_id, out, symbols);
    }
}

/// Recursively extract the leaf type name from a type AST node.
fn extract_type_leaf<'a>(node: TsNode<'a>, src: &'a str) -> Option<String> {
    match node.kind() {
        "type_identifier" | "identifier" => {
            node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string())
        }
        "generic_type" => node.named_child(0).and_then(|c| extract_type_leaf(c, src)),
        "scoped_type_identifier" => node.utf8_text(src.as_bytes()).ok().map(|s| {
            s.rsplit("::")
                .next()
                .unwrap_or(s)
                .split('<')
                .next()
                .unwrap_or(s)
                .to_string()
        }),
        "reference_type" | "mutable_specifier" => {
            let mut cursor = node.walk();
            for child in node.children(&mut cursor) {
                if let Some(name) = extract_type_leaf(child, src) {
                    return Some(name);
                }
            }
            None
        }
        _ => None,
    }
}

/// Types that should not produce typed edges (Rust primitives / built-ins).
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "bool"
            | "u8"
            | "u16"
            | "u32"
            | "u64"
            | "u128"
            | "usize"
            | "i8"
            | "i16"
            | "i32"
            | "i64"
            | "i128"
            | "isize"
            | "f32"
            | "f64"
            | "str"
            | "String"
            | "char"
            | "()"
            | "Self"
            | "self"
    )
}

/// Build the function's `Signature` and emit `has_param` / `returns` edges to
/// the (non-primitive) types in its parameter list and return position.
fn function_signature(
    fn_node: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = fn_node.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for param in params.children(&mut cursor) {
            if param.kind() != "parameter" {
                continue;
            }
            let name = param
                .child_by_field_name("pattern")
                .and_then(|p| p.utf8_text(src.as_bytes()).ok())
                .unwrap_or("_")
                .to_string();
            let ty_node = param.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            if let Some(ty_node) = ty_node
                && let Some(leaf) = extract_type_leaf(ty_node, src)
                && !is_primitive_or_ignored(&leaf)
            {
                out.edges.push(Edge {
                    source: fn_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_param".into(),
                    confidence: "EXTRACTED",
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(param)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    if let Some(ret) = fn_node.child_by_field_name("return_type") {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            sig.returns = Some(text.trim().to_string());
        }
        if let Some(leaf) = extract_type_leaf(ret, src)
            && !is_primitive_or_ignored(&leaf)
        {
            out.edges.push(Edge {
                source: fn_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "returns".into(),
                confidence: "EXTRACTED",
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

/// Build a struct's `Signature.fields` and emit `has_field` edges to the
/// (non-primitive) field types.
fn struct_signature(
    struct_node: TsNode,
    src: &str,
    file: &str,
    struct_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = struct_node.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for field in body.children(&mut cursor) {
        if field.kind() != "field_declaration" {
            continue;
        }
        let name = field
            .child_by_field_name("name")
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            .unwrap_or("_")
            .to_string();
        let ty_node = field.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        if let Some(ty_node) = ty_node
            && let Some(leaf) = extract_type_leaf(ty_node, src)
            && !is_primitive_or_ignored(&leaf)
        {
            out.edges.push(Edge {
                source: struct_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "has_field".into(),
                confidence: "EXTRACTED",
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
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

/// Expand a Rust `use` path that may contain brace groups into individual
/// fully-qualified paths. Copied from `graphy_core::extract::common`.
fn expand_import_paths(raw: &str) -> Vec<String> {
    let raw = raw.trim();
    if !raw.contains('{') {
        return vec![raw.to_string()];
    }
    let Some(open) = raw.find('{') else {
        return vec![raw.to_string()];
    };
    let prefix = raw[..open].trim_end_matches(':').to_string();
    let prefix_with_sep = if prefix.is_empty() {
        String::new()
    } else {
        format!("{prefix}::")
    };
    let body_start = open + 1;
    let mut depth = 1usize;
    let mut end = body_start;
    for (i, c) in raw[body_start..].char_indices() {
        match c {
            '{' => depth += 1,
            '}' => {
                depth -= 1;
                if depth == 0 {
                    end = body_start + i;
                    break;
                }
            }
            _ => {}
        }
    }
    if depth != 0 {
        return vec![raw.to_string()];
    }
    let body = &raw[body_start..end];
    let mut parts: Vec<String> = Vec::new();
    let mut buf = String::new();
    let mut local_depth = 0usize;
    for c in body.chars() {
        match c {
            '{' => {
                local_depth += 1;
                buf.push(c);
            }
            '}' => {
                local_depth -= 1;
                buf.push(c);
            }
            ',' if local_depth == 0 => {
                let piece = buf.trim();
                if !piece.is_empty() {
                    parts.push(piece.to_string());
                }
                buf.clear();
            }
            _ => buf.push(c),
        }
    }
    let last = buf.trim();
    if !last.is_empty() {
        parts.push(last.to_string());
    }
    let mut out: Vec<String> = Vec::new();
    for part in parts {
        let trimmed = part.split(" as ").next().unwrap_or(part.as_str()).trim();
        if trimmed.contains('{') {
            for nested in expand_import_paths(trimmed) {
                out.push(format!("{prefix_with_sep}{nested}"));
            }
        } else {
            out.push(format!("{prefix_with_sep}{trimmed}"));
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.rs", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "pub struct Widget { pub label: String, pub size: u32 }\n\
             pub fn build(widget: Widget, count: u32) -> Widget { let _ = count; widget }\n\
             pub struct Holder { pub item: Widget, pub count: u32 }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.rs::build")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "widget");
        assert_eq!(hp["attr"]["index"], 0);

        assert!(edges.iter().any(|e| e["relation"] == "returns"
            && e["source"] == "s.rs::build"
            && e["target"] == "extern::Widget"));

        let hf = edges
            .iter()
            .find(|e| e["relation"] == "has_field" && e["source"] == "s.rs::Holder")
            .expect("has_field edge");
        assert_eq!(hf["target"], "extern::Widget");
        assert_eq!(hf["attr"]["name"], "item");

        // Primitive fields (String, u32) must not produce has_field edges.
        assert!(
            !edges
                .iter()
                .any(|e| e["relation"] == "has_field" && e["source"] == "s.rs::Widget"),
            "primitive fields must not produce has_field edges"
        );

        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let build = nodes.iter().find(|n| n["id"] == "s.rs::build").unwrap();
        assert_eq!(build["signature"]["returns"], "Widget");
        let params = build["signature"]["params"].as_array().unwrap();
        assert_eq!(params.len(), 2);
        assert_eq!(params[0]["name"], "widget");
        assert_eq!(params[0]["ty"], "Widget");
        assert_eq!(params[1]["name"], "count");
        assert_eq!(params[1]["ty"], "u32");
    }
}
