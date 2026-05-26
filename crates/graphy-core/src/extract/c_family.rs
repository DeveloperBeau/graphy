//! C and C++ extractor (shared because the C++ grammar is a superset of C).

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Language, Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

#[derive(Copy, Clone)]
pub enum Flavor {
    C,
    Cpp,
}

pub fn extract(path: &Path, flavor: Flavor) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let lang: Language = match flavor {
        Flavor::C => tree_sitter_c::LANGUAGE.into(),
        Flavor::Cpp => tree_sitter_cpp::LANGUAGE.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .context("load tree-sitter-c/cpp")?;
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

fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    // function_definition / declaration → declarator → function_declarator
    // → identifier. Bound the descent at 6 steps so a pathological grammar
    // can never spin forever.
    let mut cur = node;
    for _ in 0..6 {
        let next = cur
            .child_by_field_name("declarator")
            .or_else(|| cur.child_by_field_name("name"))?;
        if next.kind() == "identifier" || next.kind() == "field_identifier" {
            return next.utf8_text(src.as_bytes()).ok();
        }
        cur = next;
    }
    None
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
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "struct_specifier" | "class_specifier" | "union_specifier" | "enum_specifier" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child,
                    );
                }
            }
            "namespace_definition" => {
                // C++ only: `namespace foo { ... }`
                // Use a file-independent canonical id so the same namespace
                // declared across multiple translation units collapses to a
                // single node during graph construction (ensure_node dedupes
                // by id) rather than accumulating ambiguous duplicates.
                if let Some(n) = child.child_by_field_name("name")
                    .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                {
                    let canonical_id = format!("namespace::{n}");
                    out.nodes.push(crate::schema::Node {
                        id: canonical_id.clone(),
                        label: n.to_string(),
                        source_file: Some(file.to_string()),
                        source_location: Some(super::common::line_loc(child)),
                        kind: Some("namespace".to_string()),
                    });
                    symbols.insert(n.to_string(), canonical_id);
                }
            }
            "preproc_include" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("preproc_include has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                emit_import(out, file, trimmed, child);
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
        if child.kind() == "function_definition"
            && let Some(name) = declarator_name(child, src)
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
            && let Some(fn_node) = child.child_by_field_name("function")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
