//! CSS language plugin for graphy.
//!
//! Selectors become nodes, `@import` becomes an edge.

use graphy_plugin_api::helpers::{EXTRACTED, Edge, Node, Output};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-css",
    extensions: ["css"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_css::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-css: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    walk(tree.root_node(), source, path, &mut out);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn walk(node: TsNode, src: &str, file: &str, out: &mut Output) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "rule_set" => {
                if let Some(selectors) = child.named_child(0)
                    && let Ok(text) = selectors.utf8_text(src.as_bytes()) {
                        let label = text.trim().to_string();
                        if !label.is_empty() {
                            out.nodes.push(Node {
                                id: format!("{file}::{label}"),
                                label,
                                source_file: Some(file.to_string()),
                                source_location: Some(format!(
                                    "L{}",
                                    child.start_position().row + 1
                                )),
                                kind: Some("selector".into()),
                            });
                        }
                    }
            }
            "import_statement" => {
                if let Ok(text) = child.utf8_text(src.as_bytes()) {
                    let target = text
                        .trim_start_matches("@import")
                        .trim()
                        .trim_end_matches(';')
                        .trim()
                        .trim_matches(|c| matches!(c, '"' | '\'' | '(' | ')' | ' '))
                        .trim_start_matches("url")
                        .trim_matches(|c| matches!(c, '(' | ')' | '"' | '\''));
                    if !target.is_empty() {
                        out.edges.push(Edge {
                            source: file.to_string(),
                            target: format!("css::{target}"),
                            relation: "imports".into(),
                            confidence: EXTRACTED,
                        });
                    }
                }
            }
            _ => {}
        }
        walk(child, src, file, out);
    }
}
