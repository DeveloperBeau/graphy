//! SQL extractor (tree-sitter-sequel).
//!
//! Emits nodes for CREATE TABLE / VIEW / FUNCTION / PROCEDURE / INDEX
//! statements. Table / function names become nodes labeled by their identifier.
//!
//! FK references: for each column definition that contains a REFERENCES clause,
//! a `references` edge is emitted from the containing table to the referenced
//! table. JOIN reference edges remain deferred.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::emit_def;
use crate::schema::{Confidence, Edge, ExtractionOutput};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
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
        if matches!(
            c.kind(),
            "identifier" | "object_reference" | "table_reference"
        ) {
            return c.utf8_text(src.as_bytes()).ok().map(|s| s.to_string());
        }
        if let Some(found) = find_identifier(c, src) {
            return Some(found);
        }
    }
    None
}

/// Collect all REFERENCES targets from column definitions inside a
/// `create_table` / `column_definitions` sub-tree.
fn collect_fk_targets(node: TsNode, src: &str) -> Vec<String> {
    let mut targets = Vec::new();
    collect_fk_targets_inner(node, src, &mut targets);
    targets
}

fn collect_fk_targets_inner(node: TsNode, src: &str, targets: &mut Vec<String>) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "column_definition" {
            // Scan the column_definition children for keyword_references followed
            // by object_reference.
            let mut saw_references = false;
            let mut c2 = child.walk();
            for col_child in child.children(&mut c2) {
                match col_child.kind() {
                    "keyword_references" => saw_references = true,
                    "object_reference" if saw_references => {
                        if let Ok(name) = col_child.utf8_text(src.as_bytes()) {
                            let name = name.trim().to_string();
                            if !name.is_empty() {
                                targets.push(name);
                            }
                        }
                        // One REFERENCES per column; stop scanning this column.
                        saw_references = false;
                    }
                    _ => {}
                }
            }
        } else {
            collect_fk_targets_inner(child, src, targets);
        }
    }
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
        ) && let Some(name) = find_identifier(child, src)
        {
            let label_kind = kind.trim_start_matches("create_");
            emit_def(out, symbols, file, label_kind, &name, child);

            // For CREATE TABLE, also emit FK reference edges.
            if kind == "create_table" {
                let source_id = format!("{file}::{name}");
                for target_name in collect_fk_targets(child, src) {
                    // Avoid self-references (degenerate case).
                    if target_name == name {
                        continue;
                    }
                    let target_id = format!("{file}::{target_name}");
                    out.edges.push(Edge {
                        source: source_id.clone(),
                        target: target_id,
                        relation: "references".into(),
                        confidence: Confidence::Extracted,
                    });
                }
            }
        }
        walk(child, src, file, out, symbols);
    }
}
