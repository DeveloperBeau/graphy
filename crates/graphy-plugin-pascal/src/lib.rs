//! Pascal / Delphi language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-pascal",
    extensions: ["pas", "pp", "dpr", "dpk", "lpr", "inc"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_pascal::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-pascal: {e}"))?;
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
        .find(|c| matches!(c.kind(), "identifier" | "name" | "type_identifier"))
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
            "declProc" | "procedure" | "function" | "declFunc" => {
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
            "declType" | "type_declaration" | "declClass" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(out, symbols, file, "type", n, child.start_position().row);
                }
            }
            "declUnit" | "unit" | "program" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(out, symbols, file, "unit", n, child.start_position().row);
                }
            }
            "declUses" | "uses_clause" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(
                    out,
                    file,
                    text.trim_start_matches("uses").trim_end_matches(';').trim(),
                    child.start_position().row,
                );
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
