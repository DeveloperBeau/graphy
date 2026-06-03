//! TOML language plugin for graphy — section headers and keys become nodes.

use graphy_plugin_api::helpers::{Node, Output, line_loc};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-toml",
    extensions: ["toml"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_toml_ng::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-toml-ng: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    walk(tree.root_node(), source, path, &mut out);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn walk(node: TsNode, src: &str, file: &str, out: &mut Output) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let kind = child.kind();
        if matches!(kind, "table" | "table_array_element" | "pair") {
            let label = match kind {
                "pair" => child
                    .child_by_field_name("key")
                    .and_then(|k| k.utf8_text(src.as_bytes()).ok())
                    .map(|s| s.to_string()),
                _ => child
                    .named_child(0)
                    .and_then(|h| h.utf8_text(src.as_bytes()).ok())
                    .map(|s| s.trim_matches(|c| matches!(c, '[' | ']')).to_string()),
            };
            if let Some(label) = label.filter(|s| !s.is_empty()) {
                let id = format!("{file}::{label}");
                out.nodes.push(Node {
                    id,
                    label,
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(child.start_position().row)),
                    kind: Some(kind.to_string()),
                    signature: None,
                });
            }
        }
        walk(child, src, file, out);
    }
}
