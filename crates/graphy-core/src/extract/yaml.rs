//! YAML extractor — mapping keys as nodes; anchor/alias reference edges.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_yaml::LANGUAGE.into())
        .context("load tree-sitter-yaml")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();

    // Phase 1: collect key nodes (yaml_key) and record anchors.
    // anchor_map: anchor_name -> node_id of the key that owns the anchored value.
    let mut anchor_map: HashMap<String, String> = HashMap::new();
    walk_keys(tree.root_node(), &src, &file, &mut out, &mut anchor_map);

    // Phase 2: collect alias reference edges into a temporary vec, then append.
    // This avoids a simultaneous immutable + mutable borrow of `out`.
    let mut alias_edges: Vec<crate::schema::Edge> = Vec::new();
    emit_alias_edges(
        tree.root_node(),
        &src,
        &file,
        &out,
        &anchor_map,
        &mut alias_edges,
    );
    out.edges.extend(alias_edges);

    Ok(out)
}

/// Walk the tree emitting yaml_key nodes and collecting anchor declarations.
///
/// Anchors appear on the VALUE side of a `block_mapping_pair`. When the key
/// label is known, we record anchor_name -> key_node_id.
fn walk_keys(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    anchor_map: &mut HashMap<String, String>,
) {
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
                let key_id = format!("{file}::{label}");
                out.nodes.push(Node {
                    id: key_id.clone(),
                    label: label.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(format!("L{}", key.start_position().row + 1)),
                    kind: Some("yaml_key".into()),
                    signature: None,
                });

                // If the VALUE side has an anchor, record it.
                if let Some(value) = child.child_by_field_name("value") {
                    collect_anchors(value, src, &key_id, anchor_map);
                }
            }
        }
        walk_keys(child, src, file, out, anchor_map);
    }
}

/// Recursively collect anchor_name -> key_id mappings from a value subtree.
fn collect_anchors(
    node: TsNode,
    src: &str,
    key_id: &str,
    anchor_map: &mut HashMap<String, String>,
) {
    if node.kind() == "anchor" {
        if let Some(name_node) = node.named_child(0)
            && let Ok(name) = name_node.utf8_text(src.as_bytes())
        {
            let name = name.trim().to_string();
            if !name.is_empty() {
                anchor_map.insert(name, key_id.to_string());
            }
        }
        return; // anchor is a leaf of this sub-tree; no need to recurse
    }
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        collect_anchors(child, src, key_id, anchor_map);
    }
}

/// Walk the tree emitting `references` edges for each alias use.
///
/// For each `block_mapping_pair`, if the key is known (has a yaml_key node),
/// and the VALUE subtree contains an alias, emit an edge from the key_id to
/// the anchor's key_id.
///
/// Note: edges are appended to `edges` only; `out` is used read-only here for
/// node lookup. We pass edges separately to avoid the borrow conflict.
fn emit_alias_edges(
    node: TsNode,
    src: &str,
    file: &str,
    out: &ExtractionOutput,
    anchor_map: &HashMap<String, String>,
    edges: &mut Vec<Edge>,
) {
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
                let key_id = format!("{file}::{label}");
                // Collect aliases in the VALUE side of this pair.
                if let Some(value) = child.child_by_field_name("value") {
                    let mut alias_names = Vec::new();
                    collect_aliases(value, src, &mut alias_names);
                    for alias_name in alias_names {
                        if let Some(target_id) = anchor_map.get(&alias_name) {
                            // Avoid self-loops.
                            if *target_id == key_id {
                                continue;
                            }
                            // Only emit if both source and target have yaml_key nodes.
                            let source_exists = out.nodes.iter().any(|n| n.id == key_id);
                            let target_exists = out.nodes.iter().any(|n| n.id == *target_id);
                            if source_exists && target_exists {
                                edges.push(Edge {
                                    source: key_id.clone(),
                                    target: target_id.clone(),
                                    relation: "references".into(),
                                    confidence: Confidence::Extracted,
                                    attr: None,
                                });
                            }
                        }
                    }
                }
            }
        }
        emit_alias_edges(child, src, file, out, anchor_map, edges);
    }
}

/// Recursively collect alias_names from a value subtree.
fn collect_aliases(node: TsNode, src: &str, aliases: &mut Vec<String>) {
    if node.kind() == "alias" {
        if let Some(name_node) = node.named_child(0)
            && let Ok(name) = name_node.utf8_text(src.as_bytes())
        {
            let name = name.trim().to_string();
            if !name.is_empty() {
                aliases.push(name);
            }
        }
        return;
    }
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        collect_aliases(child, src, aliases);
    }
}
