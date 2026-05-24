//! Svelte language plugin for graphy — surfaces `<script>` / `<style>` blocks.

use graphy_plugin_api::helpers::{Node, Output, line_loc};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-svelte",
    extensions: ["svelte"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_svelte_ng::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-svelte-ng: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    walk(tree.root_node(), path, &mut out);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn walk(node: TsNode, file: &str, out: &mut Output) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if matches!(child.kind(), "script_element" | "style_element") {
            out.nodes.push(Node {
                id: format!("{file}::{}", child.kind()),
                label: child.kind().trim_end_matches("_element").to_string(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(child.start_position().row)),
                kind: Some("svelte_block".into()),
            });
        }
        walk(child, file, out);
    }
}
