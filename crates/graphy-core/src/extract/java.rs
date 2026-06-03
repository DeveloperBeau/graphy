//! Java extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

/// Recursively collect leaf type names from a Java type node. A `generic_type`
/// pushes its BASE name then recurses into each type argument:
/// `Map<String, Pair<Foo, Bar>>` -> `[Map, String, Pair, Foo, Bar]`. Container
/// suppression happens at the emit site via `is_primitive_or_ignored`, not here,
/// so user generics like `Pair` keep their own edge. Java primitives are distinct
/// node kinds (integral_type / floating_point_type / boolean_type / void_type)
/// and push nothing.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "scoped_type_identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes())
                && let Some(last) = s.rsplit('.').next()
            {
                out.push(last.to_string());
            }
        }
        "generic_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c) {
                if ch.kind() == "type_arguments" {
                    let mut cc = ch.walk();
                    for arg in ch.children(&mut cc).filter(|a| a.is_named()) {
                        extract_type_leaves(arg, src, out);
                    }
                } else {
                    extract_type_leaves(ch, src, out);
                }
            }
        }
        "array_type" => {
            if let Some(e) = node.child_by_field_name("element") {
                extract_type_leaves(e, src, out);
            }
        }
        _ => {}
    }
}

/// Collect type leaves, de-duped order-preservingly (`Pair<Foo, Foo>` -> one
/// `Foo`).
fn type_leaves(node: TsNode, src: &str) -> Vec<String> {
    let mut raw = Vec::new();
    extract_type_leaves(node, src, &mut raw);
    let mut out = Vec::new();
    for s in raw {
        if !out.contains(&s) {
            out.push(s);
        }
    }
    out
}

/// Java stdlib generic containers that should not produce typed edges so only
/// their inner meaningful type arguments get edges. Java primitives never reach
/// here (they are distinct node kinds that push no leaf).
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "List"
            | "ArrayList"
            | "LinkedList"
            | "Map"
            | "HashMap"
            | "TreeMap"
            | "Set"
            | "HashSet"
            | "TreeSet"
            | "Collection"
            | "Iterable"
            | "Optional"
            | "Future"
            | "Stream"
            | "Comparable"
    )
}

/// Build a method/constructor `Signature` and emit `has_param` / `returns`
/// edges plus the referenced `extern::<Type>` type nodes.
fn java_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if p.kind() != "formal_parameter" {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let name = p
                .child_by_field_name("name")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                .map(|s| s.to_string())
                .unwrap_or_else(|| "_".to_string());
            if let Some(t) = ty_node {
                for leaf in type_leaves(t, src) {
                    if is_primitive_or_ignored(&leaf) {
                        continue;
                    }
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
                        source_location: Some(line_loc(p)),
                        kind: Some("type".into()),
                        signature: None,
                    });
                }
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    // Constructors have no `type` field; Option handling makes that a no-op.
    if let Some(ret) = decl.child_by_field_name("type") {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            sig.returns = Some(text.trim().to_string());
        }
        for leaf in type_leaves(ret, src) {
            if is_primitive_or_ignored(&leaf) {
                continue;
            }
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
                source_location: Some(line_loc(ret)),
                kind: Some("type".into()),
                signature: None,
            });
        }
    }
    sig
}

/// Build a class `Signature.fields` and emit `has_field` edges for non-primitive
/// field types. Returns an empty signature when the declaration has no body
/// (interfaces/enums/records land in the same match arm in `walk`).
fn java_class_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = decl.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for field in body.children(&mut cursor) {
        // Only class instance fields; interface constants are
        // `constant_declaration`, enum fields nest under `enum_body_declarations`.
        if field.kind() != "field_declaration" {
            continue;
        }
        let ty_node = field.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        let Some(name) = field
            .child_by_field_name("declarator")
            .and_then(|d| d.child_by_field_name("name"))
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            .map(|s| s.to_string())
        else {
            continue;
        };
        if let Some(t) = ty_node {
            for leaf in type_leaves(t, src) {
                if is_primitive_or_ignored(&leaf) {
                    continue;
                }
                out.edges.push(Edge {
                    source: type_id.to_string(),
                    target: format!("extern::{leaf}"),
                    relation: "has_field".into(),
                    confidence: Confidence::Extracted,
                    attr: Some(EdgeAttr {
                        name: Some(name.clone()),
                        index: None,
                    }),
                });
                out.nodes.push(Node {
                    id: format!("extern::{leaf}"),
                    label: leaf.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(line_loc(field)),
                    kind: Some("type".into()),
                    signature: None,
                });
            }
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_java::LANGUAGE.into())
        .context("load tree-sitter-java")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    walk(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
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
        match child.kind() {
            "method_declaration" | "constructor_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = java_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "method", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "enum_declaration"
            | "record_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let node_kind = child.kind().trim_end_matches("_declaration");
                    let class_id = format!("{file}::{n}");
                    let sig = java_class_signature(child, src, file, &class_id, out);
                    emit_def(out, symbols, file, node_kind, n, child);
                    attach_signature(out, sig);
                    // Emit inherits/implements edges (after attach_signature so
                    // the extern parent nodes don't capture the signature).
                    emit_java_hierarchy(child, src, &class_id, out);
                }
            }
            "import_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                // Java wildcard `import java.util.*;` lands here intact — `*` survives
                // trim() so dedup::is_glob can later identify it.
                let target = text
                    .trim_start_matches("import")
                    .trim_end_matches(';')
                    .trim();
                emit_import(out, file, target, child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols);
    }
}

fn walk_calls(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if matches!(
            child.kind(),
            "method_declaration" | "constructor_declaration"
        ) && let Some(name) = name_of(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
    }
}

/// Walk the direct type-reference children of superclass / interfaces clauses
/// and emit `inherits` (extends) and `implements` edges.
fn emit_java_hierarchy(node: TsNode, src: &str, class_id: &str, out: &mut ExtractionOutput) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let relation = match child.kind() {
            "superclass" => "inherits",
            "super_interfaces" | "interfaces" => "implements",
            _ => continue,
        };
        // The direct children of superclass/super_interfaces include a
        // type_list or a single type node. Walk their named children to
        // find `type_identifier` leaves.
        collect_type_identifiers(child, src, class_id, relation, out);
    }
}

fn collect_type_identifiers(
    node: TsNode,
    src: &str,
    class_id: &str,
    relation: &str,
    out: &mut ExtractionOutput,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "type_identifier"
            && let Ok(name) = child.utf8_text(src.as_bytes())
        {
            let name = name.trim();
            if !name.is_empty() {
                out.edges.push(Edge {
                    source: class_id.to_string(),
                    target: format!("extern::{name}"),
                    relation: relation.to_string(),
                    confidence: Confidence::Extracted,
                    attr: None,
                });
            }
        }
        collect_type_identifiers(child, src, class_id, relation, out);
    }
}

fn collect_calls(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut ExtractionOutput,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "method_invocation"
            && let Some(fn_node) = child.child_by_field_name("name")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
