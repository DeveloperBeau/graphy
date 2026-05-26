//! Bash extractor — function definitions + `source`/`. ` includes + function-call edges.

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
        .set_language(&tree_sitter_bash::LANGUAGE.into())
        .context("load tree-sitter-bash")?;
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

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_definition"
            && let Some(n) = name_of(child, src) {
                emit_def(out, symbols, file, "function", n, child);
            }
        if child.kind() == "command" {
            // `source path/to/x.sh` or `. path/to/x.sh`
            let name = child
                .child_by_field_name("name")
                .expect("command has name field");
            let cmd = name.utf8_text(src.as_bytes()).expect("utf8 source");
            if matches!(cmd, "source" | ".") {
                let mut subc = child.walk();
                if let Some(a) = child.children_by_field_name("argument", &mut subc).next() {
                    let text = a.utf8_text(src.as_bytes()).expect("utf8 source");
                    emit_import(out, file, text, child);
                }
            }
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
        if child.kind() == "function_definition"
            && let Some(name) = name_of(child, src) {
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
        if child.kind() == "command" {
            let name = child
                .child_by_field_name("name")
                .expect("command has name field");
            let text = name.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
