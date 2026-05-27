//! Julia language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-julia",
    extensions: ["jl"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_julia::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-julia: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn julia_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor).find_map(|c| match c.kind() {
        "signature" => c
            .named_child(0)?
            .named_child(0)?
            .utf8_text(src.as_bytes())
            .ok(),
        "type_head" => {
            let mut tc = c.walk();
            c.children(&mut tc).find_map(|tch| match tch.kind() {
                "identifier" => tch.utf8_text(src.as_bytes()).ok(),
                "binary_expression" => tch
                    .named_child(0)
                    .and_then(|id| id.utf8_text(src.as_bytes()).ok()),
                _ => None,
            })
        }
        "identifier" => c.utf8_text(src.as_bytes()).ok(),
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
            "function_definition" | "short_function_definition" | "macro_definition" => {
                if let Some(n) = julia_name(child, src) {
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
            "struct_definition" | "abstract_definition" | "primitive_definition" => {
                if let Some(n) = julia_name(child, src) {
                    let kind = child.kind().trim_end_matches("_definition").to_string();
                    emit_def(out, symbols, file, &kind, n, child.start_position().row);
                }
            }
            "import_statement" | "using_statement" => {
                if let Ok(text) = child.utf8_text(src.as_bytes()) {
                    let target = text
                        .trim_start_matches("import")
                        .trim_start_matches("using")
                        .trim();
                    emit_import(out, file, target, child.start_position().row);
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
        if matches!(
            child.kind(),
            "function_definition" | "short_function_definition" | "macro_definition"
        ) && let Some(name) = julia_name(child, src)
        {
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
        if child.kind() == "signature" {
            continue;
        }
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0)
            && let Ok(text) = first.utf8_text(src.as_bytes())
        {
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
