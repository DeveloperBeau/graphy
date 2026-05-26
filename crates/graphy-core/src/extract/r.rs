//! R extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_def, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_r::LANGUAGE.into())
        .context("load tree-sitter-r")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        // `foo <- function(...) { ... }` and `foo = function(...)` are the
        // canonical R function declaration forms.
        if matches!(
            child.kind(),
            "binary_operator" | "equals_assignment" | "left_assignment"
        ) {
            let mut sub = child.walk();
            let parts: Vec<_> = child.named_children(&mut sub).collect();
            if parts.len() >= 2 {
                let lhs = parts[0];
                let rhs = parts[parts.len() - 1];
                if (rhs.kind() == "function_definition" || rhs.kind() == "function")
                    && let Ok(name) = lhs.utf8_text(src.as_bytes())
                {
                    emit_def(out, symbols, file, "function", name, child);
                }
            }
        }
        // library(foo) / require(foo) calls
        if matches!(child.kind(), "call")
            && let Some(name_node) = child.child_by_field_name("function")
            && let Ok(text) = name_node.utf8_text(src.as_bytes())
            && matches!(text, "library" | "require" | "source")
            && let Some(args) = child.child_by_field_name("arguments")
        {
            let raw = args
                .utf8_text(src.as_bytes())
                .unwrap_or("")
                .trim_matches(|c: char| matches!(c, '(' | ')' | ' '))
                .trim_matches(|c| matches!(c, '"' | '\''));
            emit_import(out, file, raw, child);
        }
        walk(child, src, file, out, symbols);
    }
}
