//! PowerShell extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_def, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_powershell::LANGUAGE.into())
        .context("load tree-sitter-powershell")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
}

fn first_identifier_text<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| matches!(c.kind(), "function_name" | "simple_name" | "identifier"))
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
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
        match child.kind() {
            "function_statement" | "function_definition" => {
                if let Some(n) = first_identifier_text(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_statement" => {
                if let Some(n) = first_identifier_text(child, src) {
                    emit_def(out, symbols, file, "class", n, child);
                }
            }
            "using_statement" | "import_module_command" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(out, file, text.trim(), child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
