//! Rust source extractor (tree-sitter).
//!
//! Emits nodes for `fn`, `struct`, `enum`, `trait`, `impl`, `mod` items and
//! edges for `use` (imports) and direct call expressions inside fn bodies.

use std::collections::HashMap;
use std::fs;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rust::LANGUAGE.into())
        .context("load tree-sitter-rust")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let mut out = ExtractionOutput::default();
    let mut symbol_idx: HashMap<String, String> = HashMap::new();
    let root = tree.root_node();
    let file_label = path.to_string_lossy().into_owned();

    walk_items(root, &src, &file_label, &mut out, &mut symbol_idx);
    add_call_edges(root, &src, &file_label, &mut out, &symbol_idx);
    Ok(out)
}

fn line_loc(node: TsNode) -> String {
    format!("L{}", node.start_position().row + 1)
}

fn make_id(file: &str, label: &str) -> String {
    format!("{file}::{label}")
}

fn walk_items(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let kind = child.kind();
        match kind {
            "function_item" | "struct_item" | "enum_item" | "trait_item"
            | "mod_item" | "impl_item" | "const_item" | "static_item" | "type_item" => {
                if let Some(name) = name_of(child, src) {
                    let id = make_id(file, &name);
                    symbols.insert(name.clone(), id.clone());
                    out.nodes.push(Node {
                        id,
                        label: name,
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(child)),
                        kind: Some(kind.trim_end_matches("_item").to_string()),
                    });
                }
            }
            "use_declaration" => {
                let text = child
                    .utf8_text(src.as_bytes())
                    .expect("utf8 source");
                let cleaned = text
                    .trim_start_matches("use ")
                    .trim_end_matches(';')
                    .trim();
                for path in crate::extract::common::expand_import_paths(cleaned) {
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
                            confidence: Confidence::Extracted,
                        });
                    }
                }
            }
            _ => {}
        }
        walk_items(child, src, file, out, symbols);
    }
}

fn name_of(node: TsNode, src: &str) -> Option<String> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
        .map(|s| s.to_string())
}

fn add_call_edges(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_item" {
            if let Some(name) = name_of(child, src) {
                let caller_id = make_id(file, &name);
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
    out: &mut ExtractionOutput,
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
                    confidence: Confidence::Inferred,
                });
            }
        }
        collect_calls_in(child, src, caller_id, out, symbols);
    }
}
