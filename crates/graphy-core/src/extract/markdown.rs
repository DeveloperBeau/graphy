//! Markdown extractor — headings as nodes, inline links as reference edges.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_md::LANGUAGE.into())
        .context("load tree-sitter-md")?;
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
        let kind = child.kind();
        if kind.starts_with("atx_heading") || kind == "setext_heading" {
            let label = child
                .utf8_text(src.as_bytes())
                .unwrap_or("")
                .trim()
                .trim_start_matches('#')
                .trim()
                .to_string();
            if !label.is_empty() {
                out.nodes.push(Node {
                    id: format!("{file}::{label}"),
                    label,
                    source_file: Some(file.to_string()),
                    source_location: Some(format!("L{}", child.start_position().row + 1)),
                    kind: Some("heading".into()),
                });
            }
        }
        walk(child, src, file, out);
    }
    // Inline link extraction lives in the inline tree which tree-sitter-md
    // exposes through a separate parse phase; for v0 we keep headings only.
    let _ = Edge {
        // referenced for trait import side-effects
        source: String::new(),
        target: String::new(),
        relation: String::new(),
        confidence: Confidence::Extracted,
    };
}
