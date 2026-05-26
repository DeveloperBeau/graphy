//! Elixir language plugin for graphy.
//!
//! Elixir's tree-sitter grammar represents almost everything as call nodes
//! (`defmodule`, `def`, `defp`, `alias`, `require`, `import` are all calls
//! whose `target` child is the keyword). We pattern-match on the target.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Node, Output, emit_call, emit_import, line_loc};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-elixir",
    extensions: ["ex", "exs"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_elixir::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-elixir: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
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
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call"
            && let Some(tgt) = target_of(child, src) {
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
                                out.nodes.push(Node {
                                    id,
                                    label: name.to_string(),
                                    source_file: Some(file.to_string()),
                                    source_location: Some(line_loc(child.start_position().row)),
                                    kind: Some(kind.into()),
                                });
                            }
                        }
                    }
                    "alias" | "import" | "require" | "use" => {
                        if let Some(arg) = argument_text(child, src) {
                            emit_import(out, file, arg, child.start_position().row);
                        }
                    }
                    _ => {
                        // ordinary call — emit as call edge with file as caller
                        let caller_id = file.to_string();
                        emit_call(out, symbols, &caller_id, tgt);
                    }
                }
            }
        walk(child, src, file, out, symbols);
    }
}
