//! JSON extractor.
//!
//! Treats top-level object keys as nodes and `$ref` string values as edges.
//! Designed for config / OpenAPI / package.json style files where structure
//! matters but there are no functions or imports to recover.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_json::LANGUAGE.into())
        .context("load tree-sitter-json")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    walk(tree.root_node(), &src, &file, &mut out);
    Ok(out)
}

fn walk(node: TsNode, src: &str, file: &str, out: &mut ExtractionOutput) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "pair" {
            let key = child
                .child_by_field_name("key")
                .expect("pair has key field");
            let raw = key.utf8_text(src.as_bytes()).expect("utf8 source");
            let label = raw.trim_matches('"').to_string();
            if !label.is_empty() {
                let id = format!("{file}::{label}");
                out.nodes.push(Node {
                    id: id.clone(),
                    label: label.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(format!("L{}", key.start_position().row + 1)),
                    kind: Some("json_key".into()),
                    signature: None,
                });
                if label == "$ref" {
                    let value = child
                        .child_by_field_name("value")
                        .expect("pair has value field");
                    let v = value.utf8_text(src.as_bytes()).expect("utf8 source");
                    let target = v.trim_matches('"').to_string();
                    if !target.is_empty() {
                        out.edges.push(Edge {
                            source: id,
                            target: format!("ref::{target}"),
                            relation: "references".into(),
                            confidence: Confidence::Extracted,
                            attr: None,
                        });
                    }
                }
            }
        }
        walk(child, src, file, out);
    }
}
