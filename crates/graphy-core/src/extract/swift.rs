//! Swift extractor.
//!
//! tree-sitter-swift surfaces declaration names through `simple_identifier`
//! (functions, properties) and `type_identifier` (classes/structs/enums/
//! protocols/actors), rather than via a `name` field. We walk the direct
//! children of each declaration looking for those kinds.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_swift::LANGUAGE.into())
        .context("load tree-sitter-swift")?;
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

fn swift_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(c.kind(), "simple_identifier" | "type_identifier") {
            return c.utf8_text(src.as_bytes()).ok();
        }
    }
    None
}

fn classify(kind: &str) -> Option<&'static str> {
    match kind {
        "function_declaration" | "init_declaration" | "deinit_declaration"
        | "protocol_function_declaration" => Some("function"),
        "class_declaration" => Some("class"),
        "protocol_declaration" => Some("protocol"),
        _ => None,
    }
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
        if let Some(kind) = classify(child.kind())
            && let Some(n) = swift_name(child, src) {
                emit_def(out, symbols, file, kind, n, child);
            }
        if child.kind() == "import_declaration"
            && let Some(first) = child.named_child(0) {
                let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(out, file, text, child);
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
        if matches!(
            child.kind(),
            "function_declaration" | "init_declaration" | "deinit_declaration"
        ) {
            let name = swift_name(child, src).unwrap_or("<anon>");
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
            && let Some(first) = child.named_child(0) {
                let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
