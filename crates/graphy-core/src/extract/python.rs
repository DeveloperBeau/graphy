//! Python extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::{Confidence, Edge, ExtractionOutput};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
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
                    let class_id = format!("{file}::{n}");
                    emit_def(out, symbols, file, "class", n, child);
                    // Emit `inherits` edge for each base class in the argument_list.
                    let mut cc = child.walk();
                    for gc in child.children(&mut cc) {
                        if gc.kind() == "argument_list" {
                            let mut bc = gc.walk();
                            for base in gc.children(&mut bc) {
                                if base.kind() == "identifier"
                                    && let Ok(base_name) = base.utf8_text(src.as_bytes())
                                {
                                    let base_name = base_name.trim();
                                    if !base_name.is_empty() {
                                        let target_id = format!("extern::{base_name}");
                                        out.edges.push(Edge {
                                            source: class_id.clone(),
                                            target: target_id,
                                            relation: "inherits".into(),
                                            confidence: Confidence::Extracted,
                                        });
                                    }
                                }
                            }
                        }
                    }
                }
            }
            "import_statement" | "import_from_statement" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text.trim();
                let (module, names_raw): (String, Option<String>) =
                    if let Some(rest) = cleaned.strip_prefix("from ") {
                        if let Some((m, n)) = rest.split_once(" import ") {
                            (m.trim().to_string(), Some(n.trim().to_string()))
                        } else {
                            (rest.trim().to_string(), None)
                        }
                    } else if let Some(rest) = cleaned.strip_prefix("import ") {
                        // `import a, b, c` — expand each as its own top-level module.
                        (String::new(), Some(rest.trim().to_string()))
                    } else {
                        (cleaned.to_string(), None)
                    };
                let brace_form = if let Some(ref n) = names_raw {
                    format!("{{{n}}}")
                } else {
                    module.clone()
                };
                for path in crate::extract::common::expand_import_paths(&brace_form) {
                    if path.is_empty() {
                        continue;
                    }
                    // Convert the leaf path from ::- to dot-separated form, then
                    // join it with the module using a single dot separator.
                    // This avoids the double-dot problem: `from . import helper`
                    // would become `..helper` if we naively replaced `::` globally
                    // on a normalised string like `.::helper`.
                    let leaf = path.replace("::", ".");
                    let label = if !module.is_empty() {
                        if module.ends_with('.') {
                            // module is already a trailing-dot relative prefix (e.g. "..", ".")
                            format!("{module}{leaf}")
                        } else {
                            format!("{module}.{leaf}")
                        }
                    } else {
                        leaf
                    };
                    emit_import(out, file, &label, child);
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
        if child.kind() == "function_definition"
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
