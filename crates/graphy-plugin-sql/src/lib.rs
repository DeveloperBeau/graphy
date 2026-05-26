//! SQL language plugin for graphy (tree-sitter-sequel).

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_def};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-sql",
    extensions: ["sql"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_sequel::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-sequel: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn find_identifier(node: TsNode, src: &str) -> Option<String> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(
            c.kind(),
            "identifier" | "object_reference" | "table_reference"
        ) {
            return c.utf8_text(src.as_bytes()).ok().map(|s| s.to_string());
        }
        if let Some(found) = find_identifier(c, src) {
            return Some(found);
        }
    }
    None
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
        let kind = child.kind();
        if matches!(
            kind,
            "create_table"
                | "create_view"
                | "create_function"
                | "create_procedure"
                | "create_index"
                | "create_schema"
                | "create_type"
                | "create_materialized_view"
        ) && let Some(name) = find_identifier(child, src)
        {
            let label_kind = kind.trim_start_matches("create_");
            emit_def(
                out,
                symbols,
                file,
                label_kind,
                &name,
                child.start_position().row,
            );
        }
        walk(child, src, file, out, symbols);
    }
}
