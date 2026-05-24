//! PowerShell language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-powershell",
    extensions: ["ps1"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_powershell::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-powershell: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn first_identifier_text<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| matches!(c.kind(), "function_name" | "simple_name" | "identifier"))
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
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
            "function_statement" | "function_definition" => {
                if let Some(n) = first_identifier_text(child, src) {
                    emit_def(out, symbols, file, "function", n, child.start_position().row);
                }
            }
            "class_statement" => {
                if let Some(n) = first_identifier_text(child, src) {
                    emit_def(out, symbols, file, "class", n, child.start_position().row);
                }
            }
            "using_statement" | "import_module_command" => {
                if let Ok(text) = child.utf8_text(src.as_bytes()) {
                    emit_import(out, file, text.trim(), child.start_position().row);
                }
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
