//! Groovy / Gradle language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-groovy",
    extensions: ["groovy", "gradle"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_groovy::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-groovy: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
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
            "method_declaration" | "function_declaration" | "constructor_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                }
            }
            "class_declaration" | "interface_declaration" | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let kind = child.kind().trim_end_matches("_declaration").to_string();
                    emit_def(out, symbols, file, &kind, n, child.start_position().row);
                }
            }
            "import_declaration" => {
                if let Ok(text) = child.utf8_text(src.as_bytes()) {
                    emit_import(
                        out,
                        file,
                        text.trim_start_matches("import").trim(),
                        child.start_position().row,
                    );
                }
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
