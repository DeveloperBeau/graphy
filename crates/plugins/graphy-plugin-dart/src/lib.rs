//! Dart language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-dart",
    extensions: ["dart"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_dart::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-dart: {e}"))?;
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

fn first_id<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| matches!(c.kind(), "identifier" | "type_identifier"))
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
            "function_signature" | "method_signature" | "getter_signature" | "setter_signature" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
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
            "class_definition"
            | "mixin_declaration"
            | "extension_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child
                            .kind()
                            .trim_end_matches("_definition")
                            .trim_end_matches("_declaration"),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "import_or_export" | "import_specification" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(
                    out,
                    file,
                    text.trim_start_matches("import")
                        .trim_start_matches("export")
                        .trim_end_matches(';')
                        .trim()
                        .trim_matches(|c| matches!(c, '"' | '\'')),
                    child.start_position().row,
                );
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
