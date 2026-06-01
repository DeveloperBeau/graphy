//! Dart extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_def, emit_import, emit_inherits, name_of};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_dart::LANGUAGE.into())
        .context("load tree-sitter-dart")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
}

fn first_id<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| matches!(c.kind(), "identifier" | "type_identifier"))
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
            "function_signature" | "method_signature" | "getter_signature" | "setter_signature" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_definition"
            | "class_declaration"
            | "mixin_declaration"
            | "extension_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src).or_else(|| first_id(child, src)) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child
                            .kind()
                            .trim_end_matches("_definition")
                            .trim_end_matches("_declaration"),
                        n,
                        child,
                    );
                    // Emit inherits/implements edges from superclass, mixins, interfaces.
                    let child_id = format!("{file}::{n}");
                    let mut ec = child.walk();
                    for gc in child.children(&mut ec) {
                        match gc.kind() {
                            "superclass" => {
                                // superclass -> type -> type_identifier
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if item.kind() == "type" {
                                        let mut gc3 = item.walk();
                                        for ti in item.children(&mut gc3) {
                                            if ti.kind() == "type_identifier" {
                                                if let Ok(parent) = ti.utf8_text(src.as_bytes()) {
                                                    emit_inherits(
                                                        out, &child_id, parent, "inherits", ti,
                                                    );
                                                }
                                                break;
                                            }
                                        }
                                        break;
                                    } else if item.kind() == "type_identifier" {
                                        if let Ok(parent) = item.utf8_text(src.as_bytes()) {
                                            emit_inherits(out, &child_id, parent, "inherits", item);
                                        }
                                        break;
                                    }
                                }
                            }
                            "mixins" => {
                                // mixins -> type -> type_identifier
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if item.kind() == "type" {
                                        let mut gc3 = item.walk();
                                        for ti in item.children(&mut gc3) {
                                            if ti.kind() == "type_identifier" {
                                                if let Ok(parent) = ti.utf8_text(src.as_bytes()) {
                                                    emit_inherits(
                                                        out, &child_id, parent, "inherits", ti,
                                                    );
                                                }
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                            "interfaces" => {
                                // interfaces -> type_identifier (direct) or type -> type_identifier
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if item.kind() == "type_identifier" {
                                        if let Ok(parent) = item.utf8_text(src.as_bytes()) {
                                            emit_inherits(
                                                out,
                                                &child_id,
                                                parent,
                                                "implements",
                                                item,
                                            );
                                        }
                                    } else if item.kind() == "type" {
                                        let mut gc3 = item.walk();
                                        for ti in item.children(&mut gc3) {
                                            if ti.kind() == "type_identifier" {
                                                if let Ok(parent) = ti.utf8_text(src.as_bytes()) {
                                                    emit_inherits(
                                                        out,
                                                        &child_id,
                                                        parent,
                                                        "implements",
                                                        ti,
                                                    );
                                                }
                                                break;
                                            }
                                        }
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
            "import_or_export" | "import_specification" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(
                    out,
                    file,
                    text.trim_start_matches("import")
                        .trim_start_matches("export")
                        .trim_end_matches(';')
                        .trim()
                        .trim_matches(|c| matches!(c, '"' | '\'')),
                    child,
                );
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
