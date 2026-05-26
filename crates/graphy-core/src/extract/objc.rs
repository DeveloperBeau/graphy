//! Objective-C extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_objc::LANGUAGE.into())
        .context("load tree-sitter-objc")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
}

/// Function definitions in tree-sitter-objc embed their name inside
/// `function_declarator > identifier`. Walk into the declarator chain to
/// retrieve it.
fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor).find_map(|c| match c.kind() {
        "function_declarator" => {
            let mut inner = c.walk();
            c.children(&mut inner)
                .find(|ic| matches!(ic.kind(), "identifier" | "field_identifier"))
                .and_then(|ic| ic.utf8_text(src.as_bytes()).ok())
        }
        "identifier" | "field_identifier" => c.utf8_text(src.as_bytes()).ok(),
        _ => None,
    })
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
            "class_interface"
            | "class_implementation"
            | "protocol_declaration"
            | "category_interface"
            | "category_implementation" => {
                if let Some(n) = name_of(child, src).or_else(|| declarator_name(child, src)) {
                    emit_def(out, symbols, file, "class", n, child);
                }
            }
            "method_declaration" | "method_definition" => {
                if let Some(n) = name_of(child, src).or_else(|| declarator_name(child, src)) {
                    emit_def(out, symbols, file, "method", n, child);
                }
            }
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "preproc_include" | "preproc_import" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("preproc include has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                emit_import(out, file, trimmed, child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
