//! YAML extractor — top-level mapping keys as nodes.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_yaml::LANGUAGE.into())
        .context("load tree-sitter-yaml")?;
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
        if matches!(child.kind(), "block_mapping_pair" | "flow_pair")
            && let Some(key) = child.child_by_field_name("key") {
                let label = key
                    .utf8_text(src.as_bytes())
                    .unwrap_or("")
                    .trim()
                    .to_string();
                if !label.is_empty() {
                    out.nodes.push(Node {
                        id: format!("{file}::{label}"),
                        label,
                        source_file: Some(file.to_string()),
                        source_location: Some(format!("L{}", key.start_position().row + 1)),
                        kind: Some("yaml_key".into()),
                    });
                }
            }
        walk(child, src, file, out);
    }
}
