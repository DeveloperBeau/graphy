//! PHP extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, emit_inherits, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_php::LANGUAGE_PHP.into())
        .context("load tree-sitter-php")?;
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
        match child.kind() {
            "function_definition" | "method_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "trait_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child,
                    );
                    // Emit inherits/implements edges from base_clause and class_interface_clause.
                    let child_id = format!("{file}::{n}");
                    let mut ec = child.walk();
                    for gc in child.children(&mut ec) {
                        match gc.kind() {
                            "base_clause" => {
                                // base_clause -> name (first `name` child is the parent class)
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if (item.kind() == "name" || item.kind() == "qualified_name")
                                        && let Ok(parent) = item.utf8_text(src.as_bytes())
                                    {
                                        emit_inherits(out, &child_id, parent, "inherits", item);
                                        break;
                                    }
                                }
                            }
                            "class_interface_clause" => {
                                // class_interface_clause -> name nodes (interfaces)
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if (item.kind() == "name" || item.kind() == "qualified_name")
                                        && let Ok(parent) = item.utf8_text(src.as_bytes())
                                    {
                                        emit_inherits(out, &child_id, parent, "implements", item);
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
            "namespace_use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text.trim_start_matches("use").trim_end_matches(';').trim();
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
        if matches!(child.kind(), "function_definition" | "method_declaration")
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
        if matches!(
            child.kind(),
            "function_call_expression" | "member_call_expression" | "scoped_call_expression"
        ) && let Some(fn_node) = child
            .child_by_field_name("function")
            .or_else(|| child.child_by_field_name("name"))
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
