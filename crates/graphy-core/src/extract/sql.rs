//! SQL extractor (tree-sitter-sequel).
//!
//! Emits nodes for CREATE TABLE / VIEW / FUNCTION / PROCEDURE / INDEX
//! statements. Table / function names become nodes labeled by their identifier.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::emit_def;
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_sequel::LANGUAGE.into())
        .context("load tree-sitter-sequel")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
}

fn find_identifier(node: TsNode, src: &str) -> Option<String> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(c.kind(), "identifier" | "object_reference" | "table_reference") {
            return c.utf8_text(src.as_bytes()).ok().map(|s| s.to_string());
        }
        if let Some(found) = find_identifier(c, src) {
            return Some(found);
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
        let kind = child.kind();
        if matches!(
            kind,
            "create_table"
                | "create_view"
                | "create_function"
                | "create_procedure"
                | "create_index"
                | "create_schema"
                | "create_type"
                | "create_materialized_view"
        )
            && let Some(name) = find_identifier(child, src) {
                let label_kind = kind.trim_start_matches("create_");
                emit_def(out, symbols, file, label_kind, &name, child);
            }
        walk(child, src, file, out, symbols);
    }
}
