//! Erlang language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-erlang",
    extensions: ["erl", "hrl"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_erlang::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-erlang: {e}"))?;
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
        .find(|c| matches!(c.kind(), "atom" | "var" | "name" | "macro_name"))
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
            "fun_decl" | "function_clause" | "function" => {
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
            "module_attribute" => {
                if let Some(n) = first_id(child, src) {
                    emit_def(out, symbols, file, "module", n, child.start_position().row);
                }
            }
            "wild_attribute" => {
                let text = child.utf8_text(src.as_bytes()).unwrap_or("");
                if text.starts_with("-import") || text.starts_with("-include") {
                    let trimmed = text
                        .trim_start_matches('-')
                        .trim_start_matches("import")
                        .trim_start_matches("include")
                        .trim_start_matches("_lib")
                        .trim_matches(|c: char| matches!(c, '(' | ')' | '.' | ' ' | '"'));
                    emit_import(out, file, trimmed, child.start_position().row);
                }
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
