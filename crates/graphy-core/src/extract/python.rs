//! Python extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_python::LANGUAGE.into())
        .context("load tree-sitter-python")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    walk_defs(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
}

fn walk_defs(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_definition" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_definition" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "class", n, child);
                }
            }
            "import_statement" | "import_from_statement" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text.trim();
                let normalised = if let Some(rest) = cleaned.strip_prefix("from ") {
                    if let Some((module, names)) = rest.split_once(" import ") {
                        // Wrap names in braces so the shared expander treats them uniformly.
                        format!("{module}::{{{names}}}")
                    } else {
                        cleaned.to_string()
                    }
                } else if let Some(rest) = cleaned.strip_prefix("import ") {
                    // `import a, b, c` — already a list at top level.
                    format!("{{{rest}}}")
                } else {
                    cleaned.to_string()
                };
                for path in crate::extract::common::expand_import_paths(&normalised) {
                    if !path.is_empty() {
                        // Python uses dot notation, not ::, so map back to dots.
                        let dotted = path.replace("::", ".");
                        emit_import(out, file, &dotted, child);
                    }
                }
            }
            _ => {}
        }
        walk_defs(child, src, file, out, symbols);
    }
}

fn walk_calls(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_definition" {
            if let Some(name) = name_of(child, src) {
                let caller_id = format!("{file}::{name}");
                collect_calls(child, src, &caller_id, out, symbols);
            }
        }
        walk_calls(child, src, file, out, symbols);
    }
}

fn collect_calls(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
