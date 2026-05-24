//! R language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-r",
    extensions: ["r"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_r::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-r: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
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
        if matches!(
            child.kind(),
            "binary_operator" | "equals_assignment" | "left_assignment"
        ) {
            let mut sub = child.walk();
            let parts: Vec<_> = child.named_children(&mut sub).collect();
            if parts.len() >= 2 {
                let lhs = parts[0];
                let rhs = parts[parts.len() - 1];
                if rhs.kind() == "function_definition" || rhs.kind() == "function" {
                    if let Ok(name) = lhs.utf8_text(src.as_bytes()) {
                        emit_def(out, symbols, file, "function", name, child.start_position().row);
                    }
                }
            }
        }
        if matches!(child.kind(), "call") {
            if let Some(name_node) = child.child_by_field_name("function") {
                if let Ok(text) = name_node.utf8_text(src.as_bytes()) {
                    if matches!(text, "library" | "require" | "source") {
                        if let Some(args) = child.child_by_field_name("arguments") {
                            let raw = args
                                .utf8_text(src.as_bytes())
                                .unwrap_or("")
                                .trim_matches(|c: char| matches!(c, '(' | ')' | ' '))
                                .trim_matches(|c| matches!(c, '"' | '\''));
                            emit_import(out, file, raw, child.start_position().row);
                        }
                    }
                }
            }
        }
        walk(child, src, file, out, symbols);
    }
}
