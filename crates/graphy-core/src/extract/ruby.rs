//! Ruby extractor.
//!
//! tree-sitter-ruby exposes class / module / method names as direct
//! `constant` / `identifier` children rather than via a `name` field; we
//! also treat top-level bare-identifier statements inside a method body
//! as call sites (Ruby's `foo` with no parens is a method invocation).

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
        .set_language(&tree_sitter_ruby::LANGUAGE.into())
        .context("load tree-sitter-ruby")?;
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
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "method" | "singleton_method" => {
                if let Some(n) = ruby_name(child, src) {
                    emit_def(out, symbols, file, "method", n, child);
                }
            }
            "class" | "module" => {
                if let Some(n) = ruby_name(child, src) {
                    emit_def(out, symbols, file, child.kind(), n, child);
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
                    emit_import(out, file, trimmed, child);
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
        if matches!(child.kind(), "method" | "singleton_method") {
            if let Some(name) = ruby_name(child, src) {
                let caller_id = format!("{file}::{name}");
                collect_calls(child, src, &caller_id, out, symbols);
            }
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
