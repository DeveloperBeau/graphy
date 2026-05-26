//! Erlang extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_erlang::LANGUAGE.into())
        .context("load tree-sitter-erlang")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
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
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "fun_decl" | "function_clause" | "function" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "module_attribute" => {
                if let Some(n) = first_id(child, src) {
                    emit_def(out, symbols, file, "module", n, child);
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
                    emit_import(out, file, trimmed, child);
                }
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
