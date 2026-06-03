//! SQL extractor (tree-sitter-sequel).
//!
//! Emits nodes for CREATE TABLE / VIEW / FUNCTION / PROCEDURE / INDEX
//! statements. Table / function names become nodes labeled by their identifier.
//!
//! FK references: for each column definition that contains a REFERENCES clause,
//! a `references` edge is emitted from the containing table to the referenced
//! table. JOIN reference edges remain deferred.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_def, line_loc};
use crate::schema::{Confidence, Edge, EdgeAttr, ExtractionOutput, Node, ParamSig, Signature};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_sequel::LANGUAGE.into())
        .context("load tree-sitter-sequel")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    Ok(out)
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

/// Collect all REFERENCES targets from column definitions inside a
/// `create_table` / `column_definitions` sub-tree.
fn collect_fk_targets(node: TsNode, src: &str) -> Vec<String> {
    let mut targets = Vec::new();
    collect_fk_targets_inner(node, src, &mut targets);
    targets
}

fn collect_fk_targets_inner(node: TsNode, src: &str, targets: &mut Vec<String>) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "column_definition" {
            // Scan the column_definition children for keyword_references followed
            // by object_reference.
            let mut saw_references = false;
            let mut c2 = child.walk();
            for col_child in child.children(&mut c2) {
                match col_child.kind() {
                    "keyword_references" => saw_references = true,
                    "object_reference" if saw_references => {
                        if let Ok(name) = col_child.utf8_text(src.as_bytes()) {
                            let name = name.trim().to_string();
                            if !name.is_empty() {
                                targets.push(name);
                            }
                        }
                        // One REFERENCES per column; stop scanning this column.
                        saw_references = false;
                    }
                    _ => {}
                }
            }
        } else {
            collect_fk_targets_inner(child, src, targets);
        }
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
/// non-primitive (custom) argument and return types. Every argument appears in
/// `signature.params` with its textual type. `index` counts all arguments.
fn sql_signature(
    create_fn: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
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
                    confidence: Confidence::Extracted,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: Some(index),
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(*ty_node)),
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
                    confidence: Confidence::Extracted,
                    attr: None,
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(child)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
            break;
        }
    }

    sig
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
            emit_def(out, symbols, file, label_kind, &name, child);
            if let Some(sig) = sig {
                attach_signature(out, sig);
            }

            // For CREATE TABLE, also emit FK reference edges.
            if kind == "create_table" {
                let source_id = format!("{file}::{name}");
                for target_name in collect_fk_targets(child, src) {
                    // Avoid self-references (degenerate case).
                    if target_name == name {
                        continue;
                    }
                    let target_id = format!("{file}::{target_name}");
                    out.edges.push(Edge {
                        source: source_id.clone(),
                        target: target_id,
                        relation: "references".into(),
                        confidence: Confidence::Extracted,
                        attr: None,
                    });
                }
            }
        }
        walk(child, src, file, out, symbols);
    }
}
