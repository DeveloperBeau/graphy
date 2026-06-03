//! YAML language plugin for graphy — mapping keys become nodes.

use graphy_plugin_api::helpers::{Node, Output, line_loc};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-yaml",
    extensions: ["yaml", "yml"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_yaml::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-yaml: {e}"))?;
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
        if matches!(child.kind(), "block_mapping_pair" | "flow_pair")
            && let Some(key) = child.child_by_field_name("key")
        {
            let label = key
                .utf8_text(src.as_bytes())
                .unwrap_or("")
                .trim()
                .to_string();
            if !label.is_empty() {
                out.nodes.push(Node {
                    id: format!("{file}::{label}"),
                    label,
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(key.start_position().row)),
                    kind: Some("yaml_key".into()),
                    signature: None,
                });
            }
        }
        walk(child, src, file, out);
    }
}
