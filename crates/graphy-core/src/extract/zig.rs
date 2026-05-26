//! Zig extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_zig::LANGUAGE.into())
        .context("load tree-sitter-zig")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
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
    node.children(&mut cursor).find_map(|c| {
        match c.kind() {
            "builtin_identifier" => {
                if c.utf8_text(src.as_bytes()).ok() == Some("@import") {
                    is_import = true;
                }
                None
            }
            "arguments" if is_import => {
                let mut acur = c.walk();
                c.children(&mut acur).find_map(|a| {
                    if a.kind() != "string" { return None; }
                    let mut scur = a.walk();
                    a.children(&mut scur)
                        .find(|s| s.kind() == "string_content")
                        .and_then(|s| s.utf8_text(src.as_bytes()).ok())
                })
            }
            _ => None,
        }
    })
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "variable_declaration" => {
                // Detect `const X = @import("...")` to emit an import edge,
                // and bind `X` as an importable symbol.
                let name = first_identifier(child, src);
                let mut found_import = false;
                let mut acur = child.walk();
                for c in child.children(&mut acur) {
                    if c.kind() == "builtin_function"
                        && let Some(target) = builtin_import_arg(c, src) {
                            emit_import(out, file, target, child);
                            found_import = true;
                        }
                }
                if let (Some(n), true) = (name, found_import) {
                    emit_def(out, symbols, file, "import", n, child);
                }
            }
            "function_declaration" => {
                if let Some(n) = first_identifier(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
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
    out: &mut ExtractionOutput,
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
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0) {
                let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
