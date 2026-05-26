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
        .rsplit(['.', ':', '>', ' '])
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

pub fn expand_import_paths(raw: &str) -> Vec<String> {
    let raw = raw.trim();
    // Quick path: no brace at all.
    if !raw.contains('{') {
        return vec![raw.to_string()];
    }
    // Find the matching brace pair.
    let Some(open) = raw.find('{') else {
        return vec![raw.to_string()];
    };
    let prefix = raw[..open].trim_end_matches(':').to_string();
    let prefix_with_sep = if prefix.is_empty() { String::new() } else { format!("{prefix}::") };
    // Walk the brace content respecting nested braces.
    let body_start = open + 1;
    let mut depth = 1usize;
    let mut end = body_start;
    for (i, c) in raw[body_start..].char_indices() {
        match c {
            '{' => depth += 1,
            '}' => {
                depth -= 1;
                if depth == 0 {
                    end = body_start + i;
                    break;
                }
            }
            _ => {}
        }
    }
    if depth != 0 {
        // Unbalanced -- fall back to raw.
        return vec![raw.to_string()];
    }
    let body = &raw[body_start..end];
    let mut parts: Vec<String> = Vec::new();
    let mut buf = String::new();
    let mut local_depth = 0usize;
    for c in body.chars() {
        match c {
            '{' => { local_depth += 1; buf.push(c); }
            '}' => { local_depth -= 1; buf.push(c); }
            ',' if local_depth == 0 => {
                let piece = buf.trim();
                if !piece.is_empty() {
                    parts.push(piece.to_string());
                }
                buf.clear();
            }
            _ => buf.push(c),
        }
    }
    let last = buf.trim();
    if !last.is_empty() {
        parts.push(last.to_string());
    }
    let mut out: Vec<String> = Vec::new();
    for part in parts {
        // Strip ` as <alias>`.
        let trimmed = part.split(" as ").next().unwrap_or(part.as_str()).trim();
        if trimmed.contains('{') {
            // Nested brace -- recurse.
            for nested in expand_import_paths(trimmed) {
                out.push(format!("{prefix_with_sep}{nested}"));
            }
        } else {
            out.push(format!("{prefix_with_sep}{trimmed}"));
        }
    }
    out
}

pub fn is_glob(path: &str) -> bool {
    path.ends_with("::*") || path.ends_with(".*") || path == "*"
}
