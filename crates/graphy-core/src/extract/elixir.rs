//! Elixir extractor.
//!
//! Elixir's tree-sitter grammar represents almost everything as call nodes
//! (`defmodule`, `def`, `defp`, `alias`, `require`, `import` are all calls
//! whose `target` child is the keyword). We pattern-match on the target.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_import};
use crate::schema::ExtractionOutput;

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_elixir::LANGUAGE.into())
        .context("load tree-sitter-elixir")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, None, &mut out, &mut symbols);
    Ok(out)
}

fn target_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if c.kind() == "identifier" {
            return c.utf8_text(src.as_bytes()).ok();
        }
    }
    None
}

fn argument_text<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    node.children(&mut cursor)
        .find(|c| c.kind() == "arguments")
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    current_module: Option<&str>,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call"
            && let Some(tgt) = target_of(child, src)
        {
            match tgt {
                "defmodule" | "def" | "defp" | "defmacro" | "defmacrop" => {
                    if let Some(arg) = argument_text(child, src) {
                        let name = arg
                            .split(|c: char| !(c.is_alphanumeric() || c == '_' || c == '.'))
                            .next()
                            .unwrap_or(arg);
                        if !name.is_empty() {
                            let kind = if tgt == "defmodule" {
                                "module"
                            } else {
                                "function"
                            };
                            let id = format!("{file}::{name}");
                            symbols.insert(name.to_string(), id.clone());
                            out.nodes.push(crate::schema::Node {
                                id,
                                label: name.to_string(),
                                source_file: Some(file.to_string()),
                                source_location: Some(format!(
                                    "L{}",
                                    child.start_position().row + 1
                                )),
                                kind: Some(kind.into()),
                                signature: None,
                            });
                            // Recurse with updated module context for defmodule.
                            let next_module = if tgt == "defmodule" {
                                Some(name)
                            } else {
                                current_module
                            };
                            walk(child, src, file, next_module, out, symbols);
                            continue;
                        }
                    }
                }
                "defstruct" => {
                    // defstruct has no name argument; the struct name is the enclosing module.
                    let struct_name = current_module.unwrap_or("_struct");
                    if !struct_name.is_empty() {
                        let id = format!("{file}::struct_{struct_name}");
                        symbols.insert(format!("struct_{struct_name}"), id.clone());
                        out.nodes.push(crate::schema::Node {
                            id,
                            label: struct_name.to_string(),
                            source_file: Some(file.to_string()),
                            source_location: Some(format!("L{}", child.start_position().row + 1)),
                            kind: Some("struct".into()),
                            signature: None,
                        });
                    }
                }
                "alias" | "import" | "require" | "use" => {
                    if let Some(arg) = argument_text(child, src) {
                        emit_import(out, file, arg, child);
                    }
                }
                _ => {
                    // ordinary call — emit as call edge with file as caller
                    let caller_id = file.to_string();
                    emit_call(out, symbols, &caller_id, tgt);
                }
            }
        }
        walk(child, src, file, current_module, out, symbols);
    }
}
