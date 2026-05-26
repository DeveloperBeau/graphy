//! Rust source extractor (tree-sitter).
//!
//! Emits nodes for `fn`, `struct`, `enum`, `trait`, `impl`, `mod`, `const`,
//! `static`, and `type` items, plus edges for `use` (imports), direct call
//! expressions inside fn bodies, `impl Trait for Type` (`implements`),
//! parent-to-child structural relationships (`contains`), and type usage in
//! function signatures (`references`).

use std::collections::HashMap;
use std::fs;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_rust::LANGUAGE.into())
        .context("load tree-sitter-rust")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let mut out = ExtractionOutput::default();
    let mut symbol_idx: HashMap<String, String> = HashMap::new();
    let root = tree.root_node();
    let file_label = path.to_string_lossy().into_owned();

    walk_items(root, &src, &file_label, &mut out, &mut symbol_idx);
    add_call_edges(root, &src, &file_label, &mut out, &symbol_idx);
    Ok(out)
}

fn line_loc(node: TsNode) -> String {
    format!("L{}", node.start_position().row + 1)
}

fn make_id(file: &str, label: &str) -> String {
    format!("{file}::{label}")
}

fn walk_items(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let kind = child.kind();
        match kind {
            "function_item" | "struct_item" | "enum_item" | "trait_item" | "mod_item"
            | "impl_item" | "const_item" | "static_item" | "type_item" => {
                if let Some(name) = name_of(child, src) {
                    let id = make_id(file, &name);
                    symbols.insert(name.clone(), id.clone());
                    out.nodes.push(Node {
                        id: id.clone(),
                        label: name.clone(),
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(child)),
                        kind: Some(kind.trim_end_matches("_item").to_string()),
                    });
                    // Emit references edges from function parameters and return type.
                    if kind == "function_item" {
                        emit_references_edges(child, src, file, &id, out);
                    }
                    // Emit contains edges from mod to its direct child items.
                    if kind == "mod_item" {
                        emit_contains_from_body(child, src, file, &id, out, symbols);
                    }
                }
                // Emit the implements edge for trait impls and contains edges
                // from the impl type to each method in the body.
                if kind == "impl_item" {
                    let trait_node = child.child_by_field_name("trait");
                    let type_node = child.child_by_field_name("type");
                    if let Some(ty) = type_node {
                        if let Ok(type_name) = ty.utf8_text(src.as_bytes()) {
                            let type_leaf = type_name.rsplit("::").next().unwrap_or(type_name).trim();
                            let type_leaf = type_leaf.split('<').next().unwrap_or(type_leaf).trim();
                            let impl_type_id = make_id(file, type_leaf);
                            // implements edge for trait impl.
                            if let Some(t) = trait_node {
                                if let Ok(trait_name) = t.utf8_text(src.as_bytes()) {
                                    let trait_leaf = trait_name.rsplit("::").next().unwrap_or(trait_name).trim();
                                    let trait_leaf = trait_leaf.split('<').next().unwrap_or(trait_leaf).trim();
                                    let target_id = format!("extern::{trait_leaf}");
                                    out.edges.push(Edge {
                                        source: impl_type_id.clone(),
                                        target: target_id,
                                        relation: "implements".into(),
                                        confidence: Confidence::Inferred,
                                    });
                                }
                            }
                            // contains edges from the impl type to each method.
                            emit_contains_from_body(child, src, file, &impl_type_id, out, symbols);
                        }
                    }
                }
            }
            "use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text.trim_start_matches("use ").trim_end_matches(';').trim();
                for path in crate::extract::common::expand_import_paths(cleaned) {
                    let target = path.trim().to_string();
                    if !target.is_empty() {
                        let import_id = format!("extern::{target}");
                        out.nodes.push(Node {
                            id: import_id.clone(),
                            label: target,
                            source_file: Some(file.to_string()),
                            source_location: Some(line_loc(child)),
                            kind: Some("import".into()),
                        });
                        out.edges.push(Edge {
                            source: file.to_string(),
                            target: import_id,
                            relation: "imports".into(),
                            confidence: Confidence::Extracted,
                        });
                    }
                }
            }
            _ => {}
        }
        walk_items(child, src, file, out, symbols);
    }
}

/// Emit `contains` edges from `parent_id` to every `function_item` found
/// directly inside the body of `node`.  Used for both `impl_item` and
/// `mod_item` bodies.
fn emit_contains_from_body(
    node: TsNode,
    src: &str,
    file: &str,
    parent_id: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    // tree-sitter-rust uses a "body" field for both mod_item and impl_item.
    let body = match node.child_by_field_name("body") {
        Some(b) => b,
        None => return,
    };
    let mut cursor = body.walk();
    for child in body.children(&mut cursor) {
        if child.kind() == "function_item" {
            if let Some(name) = name_of(child, src) {
                let child_id = make_id(file, &name);
                symbols.insert(name, child_id.clone());
                out.edges.push(Edge {
                    source: parent_id.to_string(),
                    target: child_id,
                    relation: "contains".into(),
                    confidence: Confidence::Extracted,
                });
            }
        }
    }
}

/// Emit `references` edges from `fn_id` to each named type mentioned in the
/// function's parameter list and return type.
fn emit_references_edges(
    fn_node: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) {
    // Walk parameters field.
    if let Some(params) = fn_node.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        for param in params.children(&mut cursor) {
            if param.kind() == "parameter" {
                if let Some(ty_node) = param.child_by_field_name("type") {
                    emit_type_reference(ty_node, src, file, fn_id, out);
                }
            }
        }
    }
    // Walk return_type field.
    if let Some(ret) = fn_node.child_by_field_name("return_type") {
        emit_type_reference(ret, src, file, fn_id, out);
    }
}

/// Emit a single `references` edge from `source_id` to the type named by
/// `type_node`, stripping generic arguments.  Emits both an extern target
/// (for unresolved types) and a local target (so dedup can collapse to a
/// locally defined type).
fn emit_type_reference(
    type_node: TsNode,
    src: &str,
    file: &str,
    source_id: &str,
    out: &mut ExtractionOutput,
) {
    let type_name = extract_type_leaf(type_node, src);
    if let Some(name) = type_name {
        if is_primitive_or_ignored(&name) {
            return;
        }
        let extern_target = format!("extern::{name}");
        out.edges.push(Edge {
            source: source_id.to_string(),
            target: extern_target,
            relation: "references".into(),
            confidence: Confidence::Inferred,
        });
        // Local target lets dedup resolve to a node defined in the same file.
        let local_target = make_id(file, &name);
        out.edges.push(Edge {
            source: source_id.to_string(),
            target: local_target,
            relation: "references".into(),
            confidence: Confidence::Inferred,
        });
    }
}

/// Recursively extract the leaf type name from a type AST node.
fn extract_type_leaf<'a>(node: TsNode<'a>, src: &'a str) -> Option<String> {
    match node.kind() {
        "type_identifier" | "identifier" => {
            node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string())
        }
        "generic_type" => {
            // First named child is the base type, e.g. Vec<T> -> Vec.
            node.named_child(0).and_then(|c| extract_type_leaf(c, src))
        }
        "scoped_type_identifier" => {
            // Take the last path segment and strip generics.
            node.utf8_text(src.as_bytes()).ok().map(|s| {
                s.rsplit("::").next().unwrap_or(s).split('<').next().unwrap_or(s).to_string()
            })
        }
        "reference_type" | "mutable_specifier" => {
            // Walk children to find the inner type (e.g. &T -> T).
            let mut cursor = node.walk();
            for child in node.children(&mut cursor) {
                if let Some(name) = extract_type_leaf(child, src) {
                    return Some(name);
                }
            }
            None
        }
        _ => None,
    }
}

/// Returns true for types that should not produce `references` edges because
/// they are either Rust primitives or well-known built-in names.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "bool" | "u8" | "u16" | "u32" | "u64" | "u128" | "usize"
            | "i8" | "i16" | "i32" | "i64" | "i128" | "isize"
            | "f32" | "f64" | "str" | "String" | "char" | "()" | "Self" | "self"
    )
}

fn name_of(node: TsNode, src: &str) -> Option<String> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
        .map(|s| s.to_string())
}

fn add_call_edges(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "function_item"
            && let Some(name) = name_of(child, src)
        {
            let caller_id = make_id(file, &name);
            collect_calls_in(child, src, &caller_id, out, symbols);
        }
        add_call_edges(child, src, file, out, symbols);
    }
}

fn collect_calls_in(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call_expression" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call_expression has function field");
            let callee = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            let leaf = callee.rsplit("::").next().unwrap_or(callee);
            if let Some(target_id) = symbols.get(leaf) {
                out.edges.push(Edge {
                    source: caller_id.to_string(),
                    target: target_id.clone(),
                    relation: "calls".into(),
                    confidence: Confidence::Inferred,
                });
            }
        }
        collect_calls_in(child, src, caller_id, out, symbols);
    }
}
