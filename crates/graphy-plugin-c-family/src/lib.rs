//! C / C++ language plugin for graphy.
//!
//! The C++ tree-sitter grammar is a superset of C; we dispatch based on the
//! file extension and use the matching grammar.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Language, Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-c-family",
    extensions: ["c", "h", "cpp", "cc", "cxx", "hpp"],
    extract_json: extract_to_json,
}

#[derive(Copy, Clone)]
enum Flavor {
    C,
    Cpp,
}

fn flavor_for(path: &str) -> Flavor {
    let lower = path.to_ascii_lowercase();
    if lower.ends_with(".cpp")
        || lower.ends_with(".cc")
        || lower.ends_with(".cxx")
        || lower.ends_with(".hpp")
    {
        Flavor::Cpp
    } else {
        Flavor::C
    }
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let flavor = flavor_for(path);
    let lang: Language = match flavor {
        Flavor::C => tree_sitter_c::LANGUAGE.into(),
        Flavor::Cpp => tree_sitter_cpp::LANGUAGE.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .map_err(|e| format!("load tree-sitter-c/cpp: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    // function_definition / declaration → declarator → function_declarator
    // → identifier. Bound the descent at 6 steps so a pathological grammar
    // can never spin forever.
    let mut cur = node;
    for _ in 0..6 {
        let next = cur
            .child_by_field_name("declarator")
            .or_else(|| cur.child_by_field_name("name"))?;
        if next.kind() == "identifier" || next.kind() == "field_identifier" {
            return next.utf8_text(src.as_bytes()).ok();
        }
        cur = next;
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
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
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
            "struct_specifier" | "class_specifier" | "union_specifier" | "enum_specifier" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "preproc_include" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("preproc_include has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                emit_import(out, file, trimmed, child.start_position().row);
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
        if child.kind() == "function_definition"
            && let Some(name) = declarator_name(child, src)
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
        if child.kind() == "call_expression"
            && let Some(fn_node) = child.child_by_field_name("function")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
