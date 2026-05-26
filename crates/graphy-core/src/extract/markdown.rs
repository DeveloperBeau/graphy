//! Markdown extractor — headings as nodes, inline links as reference edges.
//!
//! Uses tree-sitter-md's MarkdownParser (two-phase parse) to access inline
//! content. For each inline link `[text](dest)`, if `dest` is not an
//! http/https URL, a `references` edge is emitted with target `link::<dest>`.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::Node as TsNode;
use tree_sitter_md::{MarkdownParser, MarkdownTree};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = MarkdownParser::default();
    let Some(tree) = parser.parse(src.as_bytes(), None) else {
        // Empty or unparseable file.
        return Ok(ExtractionOutput::default());
    };
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    walk_block(tree.block_tree().root_node(), src.as_bytes(), &file, &tree, &mut out);
    Ok(out)
}

fn walk_block(node: TsNode, src: &[u8], file: &str, md_tree: &MarkdownTree, out: &mut ExtractionOutput) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let kind = child.kind();

        if kind.starts_with("atx_heading") || kind == "setext_heading" {
            let label = std::str::from_utf8(&src[child.start_byte()..child.end_byte()])
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

        if kind == "inline" {
            // Access the inline parse tree for this inline block node.
            if let Some(inline_tree) = md_tree.inline_tree(&child) {
                collect_link_edges(
                    inline_tree.root_node(),
                    src,
                    file,
                    &mut out.edges,
                );
            }
        }

        walk_block(child, src, file, md_tree, out);
    }
}

/// Walk an inline tree looking for `inline_link` nodes and emit edges for
/// local (non-http/https) destinations.
fn collect_link_edges(node: TsNode, src: &[u8], file: &str, edges: &mut Vec<Edge>) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "inline_link" {
            // Find the link_destination child.
            let mut dc = child.walk();
            for dest_child in child.children(&mut dc) {
                if dest_child.kind() == "link_destination" {
                    let dest = std::str::from_utf8(
                        &src[dest_child.start_byte()..dest_child.end_byte()],
                    )
                    .unwrap_or("")
                    .trim();
                    // Filter external URLs.
                    if !dest.is_empty()
                        && !dest.starts_with("http://")
                        && !dest.starts_with("https://")
                    {
                        edges.push(Edge {
                            source: file.to_string(),
                            target: format!("link::{dest}"),
                            relation: "references".into(),
                            confidence: Confidence::Extracted,
                        });
                    }
                }
            }
        }
        collect_link_edges(child, src, file, edges);
    }
}
