//! Zig language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-zig",
    extensions: ["zig"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_zig::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-zig: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn first_identifier<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| c.kind() == "identifier")
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
}

fn builtin_import_arg<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    let mut is_import = false;
    node.children(&mut cursor).find_map(|c| match c.kind() {
        "builtin_identifier" => {
            if c.utf8_text(src.as_bytes()).ok() == Some("@import") {
                is_import = true;
            }
            None
        }
        "arguments" if is_import => {
            let mut acur = c.walk();
            c.children(&mut acur).find_map(|a| {
                if a.kind() != "string" {
                    return None;
                }
                let mut scur = a.walk();
                a.children(&mut scur)
                    .find(|s| s.kind() == "string_content")
                    .and_then(|s| s.utf8_text(src.as_bytes()).ok())
            })
        }
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
            "variable_declaration" => {
                let name = first_identifier(child, src);
                let mut found_import = false;
                let mut acur = child.walk();
                for c in child.children(&mut acur) {
                    if c.kind() == "builtin_function"
                        && let Some(target) = builtin_import_arg(c, src)
                    {
                        emit_import(out, file, target, child.start_position().row);
                        found_import = true;
                    }
                }
                if let (Some(n), true) = (name, found_import) {
                    emit_def(out, symbols, file, "import", n, child.start_position().row);
                }
            }
            "function_declaration" => {
                if let Some(n) = first_identifier(child, src) {
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
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}

fn walk_calls(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_declaration" {
            let name = first_identifier(child, src).unwrap_or("<anon>");
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
    }
}

fn collect_calls(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0)
            && let Ok(text) = first.utf8_text(src.as_bytes())
        {
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
