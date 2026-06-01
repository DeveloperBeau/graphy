//! Groovy / Gradle extractor.

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
        .set_language(&tree_sitter_groovy::LANGUAGE.into())
        .context("load tree-sitter-groovy")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
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
            "method_declaration" | "function_declaration" | "constructor_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child);
                }
            }
            "class_declaration" | "interface_declaration" | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child,
                    );
                    // Emit inherits edges from superclass and super_interfaces.
                    let child_id = format!("{file}::{n}");
                    let mut ec = child.walk();
                    for gc in child.children(&mut ec) {
                        match gc.kind() {
                            "superclass" => {
                                // Direct type_identifier child is the parent class.
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if item.kind() == "type_identifier"
                                        && let Ok(parent) = item.utf8_text(src.as_bytes())
                                    {
                                        emit_inherits(out, &child_id, parent, "inherits", item);
                                    }
                                }
                            }
                            "super_interfaces" => {
                                // type_list -> type_identifier or direct type_identifier.
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if item.kind() == "type_list"
                                        || item.kind() == "super_interfaces"
                                    {
                                        let mut gc3 = item.walk();
                                        for ti in item.children(&mut gc3) {
                                            if ti.kind() == "type_identifier"
                                                && let Ok(parent) = ti.utf8_text(src.as_bytes())
                                            {
                                                emit_inherits(
                                                    out,
                                                    &child_id,
                                                    parent,
                                                    "implements",
                                                    ti,
                                                );
                                            }
                                        }
                                    } else if item.kind() == "type_identifier"
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
            "import_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_import(out, file, text.trim_start_matches("import").trim(), child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}
