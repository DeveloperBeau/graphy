//! Svelte component extractor.
//!
//! Surfaces `<script>` / `<style>` blocks as `svelte_block` nodes, and also
//! parses the raw JavaScript inside each `<script>` block to emit `function`,
//! `import`, and other JS nodes into the same output. This means a single
//! `.svelte` file produces both the block-level structural node and the
//! inner JS symbol nodes.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::js_ts::{self, Flavor};
use crate::schema::{ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_svelte_ng::LANGUAGE.into())
        .context("load tree-sitter-svelte-ng")?;
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
        if matches!(child.kind(), "script_element" | "style_element") {
            let block_label = child.kind().trim_end_matches("_element").to_string();
            out.nodes.push(Node {
                id: format!("{file}::{}", child.kind()),
                label: block_label.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(format!("L{}", child.start_position().row + 1)),
                kind: Some("svelte_block".into()),
            });

            // For script blocks, re-parse the raw JS content through the JS extractor
            // so that function declarations, imports, etc. are emitted as first-class nodes.
            if child.kind() == "script_element" {
                if let Some(js_src) = extract_raw_text(child, src) {
                    if let Ok(js_out) = js_ts::extract_src(js_src, file, Flavor::Javascript) {
                        out.nodes.extend(js_out.nodes);
                        out.edges.extend(js_out.edges);
                    }
                }
            }
        }
        walk(child, src, file, out);
    }
}

/// Returns the text of a `raw_text` child node, if present.
fn extract_raw_text<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| c.kind() == "raw_text")
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
}
