//! Shared helpers across per-language extractors.

use std::collections::HashMap;

use tree_sitter::Node as TsNode;

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn line_loc(node: TsNode) -> String {
    format!("L{}", node.start_position().row + 1)
}

pub fn make_id(file: &str, label: &str) -> String {
    format!("{file}::{label}")
}

pub fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

pub fn emit_def(
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
    file: &str,
    kind: &str,
    name: &str,
    node: TsNode,
) {
    let id = make_id(file, name);
    symbols.insert(name.to_string(), id.clone());
    out.nodes.push(Node {
        id,
        label: name.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(node)),
        kind: Some(kind.to_string()),
    });
}

pub fn emit_import(
    out: &mut ExtractionOutput,
    file: &str,
    target: &str,
    node: TsNode,
) {
    let target = target.trim();
    if target.is_empty() {
        return;
    }
    let import_id = format!("extern::{target}");
    out.nodes.push(Node {
        id: import_id.clone(),
        label: target.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(node)),
        kind: Some("import".into()),
    });
    out.edges.push(Edge {
        source: file.to_string(),
        target: import_id,
        relation: "imports".into(),
        confidence: Confidence::Extracted,
    });
}

pub fn emit_call(
    out: &mut ExtractionOutput,
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
            confidence: Confidence::Inferred,
        });
    }
}
