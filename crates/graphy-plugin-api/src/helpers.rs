//! Shared helper types + fns reused by every language plugin.
//!
//! Plugins typically build an [`Output`] struct, call [`emit_def`] /
//! [`emit_import`] / [`emit_call`] / [`name_of`] / [`line_loc`] while
//! walking the tree-sitter AST, then serialize the result via serde.
//!
//! These mirror the host's `graphy-core::schema::ExtractionOutput` so the
//! host can deserialize the JSON blob without any conversion.

use std::collections::HashMap;

use serde::Serialize;

#[derive(Serialize, Default, Debug)]
pub struct Output {
    pub nodes: Vec<Node>,
    pub edges: Vec<Edge>,
}

#[derive(Serialize, Debug, Clone)]
pub struct Node {
    pub id: String,
    pub label: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub source_file: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub source_location: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub kind: Option<String>,
}

#[derive(Serialize, Debug, Clone)]
pub struct Edge {
    pub source: String,
    pub target: String,
    pub relation: String,
    pub confidence: &'static str,
}

pub const EXTRACTED: &str = "EXTRACTED";
pub const INFERRED: &str = "INFERRED";

/// Format a tree-sitter `Node`'s start row as `L<n>` (1-indexed).
pub fn line_loc(start_row: usize) -> String {
    format!("L{}", start_row + 1)
}

/// Append a definition node + register the symbol so later call edges can
/// resolve a bare leaf reference back to this id.
pub fn emit_def(
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
    file: &str,
    kind: &str,
    name: &str,
    start_row: usize,
) {
    let id = format!("{file}::{name}");
    symbols.insert(name.to_string(), id.clone());
    out.nodes.push(Node {
        id,
        label: name.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(start_row)),
        kind: Some(kind.to_string()),
    });
}

/// Append an import node + the `file → extern::<target>` edge.
pub fn emit_import(out: &mut Output, file: &str, target: &str, start_row: usize) {
    let target = target.trim();
    if target.is_empty() {
        return;
    }
    let import_id = format!("extern::{target}");
    out.nodes.push(Node {
        id: import_id.clone(),
        label: target.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(start_row)),
        kind: Some("import".into()),
    });
    out.edges.push(Edge {
        source: file.to_string(),
        target: import_id,
        relation: "imports".into(),
        confidence: EXTRACTED,
    });
}

/// Emit a call edge if `callee_text`'s rightmost identifier is in the
/// symbol table. Path/separator forms (`foo::bar`, `obj.bar`, `mod:bar`)
/// are split to their leaf.
pub fn emit_call(
    out: &mut Output,
    symbols: &HashMap<String, String>,
    caller_id: &str,
    callee_text: &str,
) {
    let leaf = callee_text
        .rsplit(|c: char| matches!(c, '.' | ':' | '>' | ' '))
        .next()
        .unwrap_or(callee_text);
    if let Some(target_id) = symbols.get(leaf) {
        out.edges.push(Edge {
            source: caller_id.to_string(),
            target: target_id.clone(),
            relation: "calls".into(),
            confidence: INFERRED,
        });
    }
}
