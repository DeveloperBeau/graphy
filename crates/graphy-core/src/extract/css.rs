//! CSS extractor — selectors become nodes, `@import` becomes an edge.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_css::LANGUAGE.into())
        .context("load tree-sitter-css")?;
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
        match child.kind() {
            "rule_set" => {
                if let Some(selectors) = child.named_child(0) {
                    let label = selectors
                        .utf8_text(src.as_bytes())
                        .expect("utf8 source")
                        .trim()
                        .to_string();
                    if !label.is_empty() {
                        out.nodes.push(Node {
                            id: format!("{file}::{label}"),
                            label,
                            source_file: Some(file.to_string()),
                            source_location: Some(format!("L{}", child.start_position().row + 1)),
                            kind: Some("selector".into()),
                        });
                    }
                }
            }
            "import_statement" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("@import")
                    .trim()
                    .trim_end_matches(';')
                    .trim()
                    .trim_matches(|c| matches!(c, '"' | '\'' | '(' | ')' | ' '))
                    .trim_start_matches("url")
                    .trim_matches(|c| matches!(c, '(' | ')' | '"' | '\''));
                if !target.is_empty() {
                    out.edges.push(Edge {
                        source: file.to_string(),
                        target: format!("css::{target}"),
                        relation: "imports".into(),
                        confidence: Confidence::Extracted,
                    });
                }
            }
            _ => {}
        }
        walk(child, src, file, out);
    }
}
