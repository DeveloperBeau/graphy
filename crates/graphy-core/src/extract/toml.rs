//! TOML extractor — section headers, array-of-tables headers, and key-value
//! pair nodes at every depth.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_toml_ng::LANGUAGE.into())
        .context("load tree-sitter-toml-ng")?;
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
        if matches!(kind, "table" | "table_array_element" | "pair") {
            let label = match kind {
                "pair" => {
                    // tree-sitter-toml-ng does not expose "key" as a named field;
                    // the key is the first named child (bare_key or dotted_key).
                    child
                        .child_by_field_name("key")
                        .or_else(|| child.named_child(0))
                        .and_then(|k| k.utf8_text(src.as_bytes()).ok())
                        .map(|s| s.to_string())
                }
                _ => child
                    .named_child(0)
                    .and_then(|h| h.utf8_text(src.as_bytes()).ok())
                    .map(|s| s.trim_matches(|c| matches!(c, '[' | ']')).to_string()),
            };
            if let Some(label) = label.filter(|s| !s.is_empty()) {
                let id = format!("{file}::{label}");
                out.nodes.push(Node {
                    id,
                    label,
                    source_file: Some(file.to_string()),
                    source_location: Some(format!("L{}", child.start_position().row + 1)),
                    kind: Some(kind.to_string()),
                });
            }
        }
        walk(child, src, file, out);
    }
}
