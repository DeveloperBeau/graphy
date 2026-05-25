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
}

#[derive(Serialize)]
struct Edge {
    source: String,
    target: String,
    relation: String,
    confidence: &'static str,
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
            "function_item" | "struct_item" | "enum_item" | "trait_item"
            | "mod_item" | "impl_item" => {
                if let Some(name) = name_of(child, src) {
                    let id = format!("{file}::{name}");
                    symbols.insert(name.to_string(), id.clone());
                    out.nodes.push(Node {
                        id,
                        label: name.to_string(),
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(child)),
                        kind: Some(kind.trim_end_matches("_item").to_string()),
                    });
                }
            }
            "use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text
                    .trim_start_matches("use ")
                    .trim_end_matches(';')
                    .trim();
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
                        });
                        out.edges.push(Edge {
                            source: file.to_string(),
                            target: import_id,
                            relation: "imports".into(),
                            confidence: "EXTRACTED",
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
        if child.kind() == "function_item" {
            if let Some(name) = name_of(child, src) {
                let caller_id = format!("{file}::{name}");
                collect_calls_in(child, src, &caller_id, out, symbols);
            }
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
                });
            }
        }
        collect_calls_in(child, src, caller_id, out, symbols);
    }
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
    let prefix_with_sep = if prefix.is_empty() { String::new() } else { format!("{prefix}::") };
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
            '{' => { local_depth += 1; buf.push(c); }
            '}' => { local_depth -= 1; buf.push(c); }
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
