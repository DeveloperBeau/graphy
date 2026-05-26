//! Julia extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_julia::LANGUAGE.into())
        .context("load tree-sitter-julia")?;
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

/// Julia exposes declaration names through several wrappers rather than a
/// `name` field. Functions and macros place the name in
/// `signature > call_expression > identifier`; structs / abstracts /
/// primitives use `type_head > identifier` (or a `binary_expression` for
/// `struct Foo <: Bar`). The `?` operator collapses defensive
/// `if let Some(..)` chains to a single line so coverage doesn't fragment.
fn julia_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor).find_map(|c| match c.kind() {
        "signature" => c
            .named_child(0)?
            .named_child(0)?
            .utf8_text(src.as_bytes())
            .ok(),
        "type_head" => {
            let mut tc = c.walk();
            c.children(&mut tc).find_map(|tch| match tch.kind() {
                "identifier" => tch.utf8_text(src.as_bytes()).ok(),
                "binary_expression" => tch
                    .named_child(0)
                    .and_then(|id| id.utf8_text(src.as_bytes()).ok()),
                _ => None,
            })
        }
        "identifier" => c.utf8_text(src.as_bytes()).ok(),
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
            "function_definition" | "short_function_definition" | "macro_definition" => {
                if let Some(n) = julia_name(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "struct_definition" | "abstract_definition" | "primitive_definition" => {
                if let Some(n) = julia_name(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_definition"),
                        n,
                        child,
                    );
                }
            }
            "import_statement" | "using_statement" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text
                    .trim_start_matches("import")
                    .trim_start_matches("using")
                    .trim();
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
        if matches!(
            child.kind(),
            "function_definition" | "short_function_definition" | "macro_definition"
        ) && let Some(name) = julia_name(child, src)
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
    // Julia function bodies place call_expression nodes directly under the
    // function_definition (after its signature). We skip the first
    // call_expression we see if it's also the signature header, but it's
    // cheaper to emit calls only for non-header positions: a real call has
    // siblings that are statements, while the signature lives inside a
    // `signature` parent.
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "signature" {
            continue;
        }
        if child.kind() == "call_expression"
            && let Some(first) = child.named_child(0)
        {
            let text = first.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
