//! JS / TS / TSX extractors. All share the same node kinds via tree-sitter's
//! TypeScript and JavaScript grammars.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Language, Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::ExtractionOutput;

#[derive(Copy, Clone)]
pub enum Flavor {
    Javascript,
    Typescript,
    Tsx,
}

pub fn extract(path: &Path, flavor: Flavor) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path)
        .with_context(|| format!("read {}", path.display()))?;
    let lang: Language = match flavor {
        Flavor::Javascript => tree_sitter_javascript::LANGUAGE.into(),
        Flavor::Typescript => tree_sitter_typescript::LANGUAGE_TYPESCRIPT.into(),
        Flavor::Tsx => tree_sitter_typescript::LANGUAGE_TSX.into(),
    };
    let mut parser = Parser::new();
    parser.set_language(&lang).context("load tree-sitter language")?;
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
            "function_declaration" | "generator_function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_declaration" | "interface_declaration" | "type_alias_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, child.kind().trim_end_matches("_declaration"), n, child);
                }
            }
            "method_definition" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child);
                }
            }
            "import_statement" => {
                let source = child
                    .child_by_field_name("source")
                    .expect("import_statement has source field");
                let text = source.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '\''));
                emit_import(out, file, trimmed, child);
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
        if matches!(
            child.kind(),
            "function_declaration"
                | "generator_function_declaration"
                | "method_definition"
                | "arrow_function"
                | "function_expression"
        ) {
            let name = name_of(child, src).unwrap_or("<anon>");
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
        if child.kind() == "call_expression" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call_expression has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
