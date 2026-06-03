//! SQL language plugin for graphy (tree-sitter-sequel).

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, Node, Output, ParamSig, Signature, attach_signature, emit_def,
    line_loc,
};
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
            let sig = if kind == "create_function" {
                let fn_id = format!("{file}::{name}");
                Some(sql_signature(child, src, file, &fn_id, out))
            } else {
                None
            };
            emit_def(
                out,
                symbols,
                file,
                label_kind,
                &name,
                child.start_position().row,
            );
            if let Some(sig) = sig {
                attach_signature(out, sig);
            }
        }
        walk(child, src, file, out, symbols);
    }
}

/// Extract the leaf type name from a SQL argument/return type node.
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        // user type: schema.widget -> widget
        "object_reference" => node
            .utf8_text(src.as_bytes())
            .ok()
            .map(|s| s.rsplit('.').next().unwrap_or(s).trim().to_string()),
        // builtin keyword type nodes (int, text, ...) -> their text
        _ => node
            .utf8_text(src.as_bytes())
            .ok()
            .map(|s| s.trim().to_string()),
    }
}

/// SQL builtin types that should not produce typed edges (case-insensitive).
fn is_primitive_or_ignored(name: &str) -> bool {
    let n = name.to_ascii_lowercase();
    matches!(
        n.as_str(),
        "int"
            | "integer"
            | "smallint"
            | "bigint"
            | "serial"
            | "bigserial"
            | "text"
            | "varchar"
            | "char"
            | "character"
            | "boolean"
            | "bool"
            | "numeric"
            | "decimal"
            | "real"
            | "float"
            | "double"
            | "money"
            | "date"
            | "time"
            | "timestamp"
            | "timestamptz"
            | "interval"
            | "uuid"
            | "json"
            | "jsonb"
            | "bytea"
            | "void"
    )
}

/// Build a SQL function `Signature` and emit `has_param` / `returns` edges for
/// non-primitive (custom) argument and return types.
fn sql_signature(
    create_fn: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();

    // Arguments.
    let mut top = create_fn.walk();
    if let Some(args) = create_fn
        .children(&mut top)
        .find(|c| c.kind() == "function_arguments")
    {
        let mut cursor = args.walk();
        let mut index: u32 = 0;
        for arg in args.children(&mut cursor) {
            if arg.kind() != "function_argument" {
                continue;
            }
            let mut ac = arg.walk();
            let named: Vec<TsNode> = arg.children(&mut ac).filter(|c| c.is_named()).collect();
            let Some(name_node) = named.iter().find(|c| c.kind() == "identifier") else {
                continue;
            };
            let name = name_node
                .utf8_text(src.as_bytes())
                .unwrap_or("_")
                .to_string();
            let Some(ty_node) = named.iter().find(|c| c.kind() != "identifier") else {
                continue;
            };
            let ty_text = ty_node
                .utf8_text(src.as_bytes())
                .ok()
                .map(|s| s.trim().to_string());
            if let Some(leaf) =
                extract_type_leaf(*ty_node, src).filter(|l| !is_primitive_or_ignored(l))
            {
                out.edges.push(Edge {
                    source: fn_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_param".into(),
                    confidence: EXTRACTED,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(ty_node.start_position().row)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }

    // Return type: the object_reference immediately after `keyword_returns`.
    let mut rc = create_fn.walk();
    let mut saw_returns = false;
    for child in create_fn.children(&mut rc) {
        if child.kind() == "keyword_returns" {
            saw_returns = true;
            continue;
        }
        if saw_returns && child.is_named() {
            if let Ok(text) = child.utf8_text(src.as_bytes()) {
                sig.returns = Some(text.trim().to_string());
            }
            if let Some(leaf) =
                extract_type_leaf(child, src).filter(|l| !is_primitive_or_ignored(l))
            {
                out.edges.push(Edge {
                    source: fn_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "returns".into(),
                    confidence: EXTRACTED,
                    attr: None,
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(child.start_position().row)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            break;
        }
    }

    sig
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.sql", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_signature_layer() {
        let v = extract(
            "CREATE FUNCTION build(w widget_type, n integer) RETURNS widget_type AS $$ SELECT w; $$ LANGUAGE sql;\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.sql::build")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::widget_type");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 0);

        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "returns" && e["source"] == "s.sql::build")
        );
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::widget_type")
        );

        let build = nodes.iter().find(|n| n["id"] == "s.sql::build").unwrap();
        assert_eq!(build["signature"]["returns"], "widget_type");
        assert_eq!(build["signature"]["params"].as_array().unwrap().len(), 2);
    }
}
