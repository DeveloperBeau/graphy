//! Objective-C language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-objc",
    extensions: ["m", "mm"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_objc::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-objc: {e}"))?;
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

/// Function definitions in tree-sitter-objc embed their name inside
/// `function_declarator > identifier`. Walk into the declarator chain to
/// retrieve it.
fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor).find_map(|c| match c.kind() {
        "function_declarator" => {
            let mut inner = c.walk();
            c.children(&mut inner)
                .find(|ic| matches!(ic.kind(), "identifier" | "field_identifier"))
                .and_then(|ic| ic.utf8_text(src.as_bytes()).ok())
        }
        "identifier" | "field_identifier" => c.utf8_text(src.as_bytes()).ok(),
        _ => None,
    })
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
            "class_interface" | "class_implementation" | "protocol_declaration"
            | "category_interface" | "category_implementation" => {
                if let Some(n) = name_of(child, src).or_else(|| declarator_name(child, src)) {
                    emit_def(out, symbols, file, "class", n, child.start_position().row);
                }
            }
            "method_declaration" | "method_definition" => {
                if let Some(n) = name_of(child, src).or_else(|| declarator_name(child, src)) {
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                }
            }
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
                    emit_def(out, symbols, file, "function", n, child.start_position().row);
                }
            }
            "preproc_include" | "preproc_import" => {
                if let Some(path_node) = child.child_by_field_name("path") {
                    if let Ok(text) = path_node.utf8_text(src.as_bytes()) {
                        let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                        emit_import(out, file, trimmed, child.start_position().row);
                    }
                }
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
