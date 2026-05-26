//! Kotlin extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_kotlin_ng::LANGUAGE.into())
        .context("load tree-sitter-kotlin-ng")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
}

/// The tree-sitter-kotlin-ng grammar uses `class_declaration` for class,
/// interface, enum class, sealed class, data class, etc. Distinguish by
/// looking for the first unnamed keyword child.
fn kotlin_class_kind(node: tree_sitter::Node, src: &str) -> &'static str {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if !c.is_named() {
            match c.utf8_text(src.as_bytes()).unwrap_or("") {
                "interface" => return "interface",
                "enum" => return "class", // enum class -> kind=class (enum body is separate)
                _ => return "class",
            }
        }
    }
    "class"
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
            "function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_declaration" => {
                if let Some(n) = name_of(child, src) {
                    // The tree-sitter-kotlin-ng grammar uses class_declaration
                    // for class, interface, object, enum class, data class, etc.
                    // Distinguish by first unnamed keyword child.
                    let kind = kotlin_class_kind(child, src);
                    emit_def(out, symbols, file, kind, n, child);
                }
            }
            "object_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "object", n, child);
                }
            }
            "import_header" | "import_directive" | "import" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("import")
                    .trim()
                    .trim_end_matches(';');
                emit_import(out, file, target, child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
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
        if child.kind() == "function_declaration"
            && let Some(name) = name_of(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
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
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0)
        {
            let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
