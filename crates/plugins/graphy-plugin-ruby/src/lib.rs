//! Ruby language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-ruby",
    extensions: ["rb"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_ruby::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-ruby: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn ruby_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(c.kind(), "identifier" | "constant" | "scope_resolution") {
            return c.utf8_text(src.as_bytes()).ok();
        }
    }
    None
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
            "method" | "singleton_method" => {
                if let Some(n) = ruby_name(child, src) {
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                }
            }
            "class" | "module" => {
                if let Some(n) = ruby_name(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind(),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "call" => {
                let method = child
                    .child_by_field_name("method")
                    .expect("call node has method field");
                let m = method.utf8_text(src.as_bytes()).expect("utf8 source");
                if matches!(m, "require" | "require_relative" | "load") {
                    let args = child
                        .child_by_field_name("arguments")
                        .expect("require call has arguments field");
                    let text = args.utf8_text(src.as_bytes()).expect("utf8 source");
                    let trimmed = text
                        .trim_matches(|c: char| matches!(c, '(' | ')' | ' '))
                        .trim_matches(|c| matches!(c, '"' | '\''));
                    emit_import(out, file, trimmed, child.start_position().row);
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
        if matches!(child.kind(), "method" | "singleton_method")
            && let Some(name) = ruby_name(child, src)
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
        match child.kind() {
            "call" => {
                let method = child
                    .child_by_field_name("method")
                    .expect("call node has method field");
                let text = method.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
            "identifier" => {
                // Bare-identifier statement inside a method body is a method
                // call in Ruby. We only attribute it when the identifier
                // resolves to a defined symbol; otherwise it might be a local.
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
            _ => {}
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
