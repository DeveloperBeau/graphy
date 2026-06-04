//! C and C++ extractor (shared because the C++ grammar is a superset of C).

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Language, Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

#[derive(Copy, Clone)]
pub enum Flavor {
    C,
    Cpp,
}

/// Recursively collect leaf type names (including stdlib containers). A
/// `template_type` pushes its BASE name then recurses each template argument:
/// `vector<Pair<Foo, Bar>>` -> `[vector, Pair, Foo, Bar]`. A
/// `qualified_identifier` (`std::vector<Widget>`) recurses its `name` field
/// only, reducing to the last segment. Container suppression happens at the
/// emit site via `is_primitive_or_ignored`, not here, so user generics like
/// `Pair` keep their own edge.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "qualified_identifier" => {
            // `std::vector<Widget>` / `std::string` -> recurse the `name` field
            // (the trailing segment), dropping the namespace `scope`.
            if let Some(name) = node.child_by_field_name("name") {
                extract_type_leaves(name, src, out);
            }
        }
        "template_type" => {
            if let Some(base) = node.child_by_field_name("name") {
                extract_type_leaves(base, src, out);
            }
            if let Some(args) = node.child_by_field_name("arguments") {
                extract_type_leaves(args, src, out);
            }
        }
        "template_argument_list" | "type_descriptor" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                extract_type_leaves(ch, src, out);
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

/// C++ primitive / builtin types that should not produce typed edges. Secondary
/// safety net for typedef-style primitives (`size_t`, `uint32_t`, …) that parse
/// as `type_identifier` and so slip past the `primitive_type` kind gate.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "void"
            | "bool"
            | "int"
            | "unsigned"
            | "long"
            | "short"
            | "char"
            | "float"
            | "double"
            | "auto"
            | "size_t"
            | "uint8_t"
            | "uint16_t"
            | "uint32_t"
            | "uint64_t"
            | "int8_t"
            | "int16_t"
            | "int32_t"
            | "int64_t"
            // C++ stdlib generic containers (suppressed so only their inner
            // type arguments get edges). The `std::` qualified forms reduce to
            // these last segments via `qualified_identifier` recursion.
            | "vector"
            | "map"
            | "unordered_map"
            | "set"
            | "unordered_set"
            | "list"
            | "deque"
            | "array"
            | "pair"
            | "tuple"
            | "optional"
            | "unique_ptr"
            | "shared_ptr"
            | "weak_ptr"
    )
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges
/// for a C++ `function_definition`. Pure Option handling throughout so
/// constructors / destructors (no `type` field) never panic.
fn cpp_signature(
    fn_def: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let params = fn_def
        .child_by_field_name("declarator")
        .filter(|d| d.kind() == "function_declarator")
        .and_then(|d| d.child_by_field_name("parameters"));
    if let Some(params) = params {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if p.kind() != "parameter_declaration" {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let name = p
                .child_by_field_name("declarator")
                .and_then(|d| d.utf8_text(src.as_bytes()).ok())
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
    if let Some(ret) = fn_def.child_by_field_name("type") {
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

/// Build a `Signature.fields` for a C++ `struct_specifier` / `class_specifier`
/// and emit `has_field` edges. Skips method prototypes and embedded/anonymous
/// fields. Pure Option handling throughout.
fn cpp_field_signature(
    specifier: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = specifier.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for field in body.children(&mut cursor) {
        if field.kind() != "field_declaration" {
            continue;
        }
        let Some(decl) = field.child_by_field_name("declarator") else {
            continue;
        };
        // Skip method prototypes (declarator is a function_declarator).
        if decl.kind() == "function_declarator" {
            continue;
        }
        // Descend through pointer_declarator chains to the field_identifier.
        let mut cur = decl;
        let mut name: Option<String> = None;
        for _ in 0..6 {
            if cur.kind() == "field_identifier" {
                name = cur.utf8_text(src.as_bytes()).ok().map(|s| s.to_string());
                break;
            }
            match cur.child_by_field_name("declarator") {
                Some(next) => cur = next,
                None => break,
            }
        }
        let Some(name) = name else {
            continue;
        };
        let ty_node = field.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
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

pub fn extract(path: &Path, flavor: Flavor) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let lang: Language = match flavor {
        Flavor::C => tree_sitter_c::LANGUAGE.into(),
        Flavor::Cpp => tree_sitter_cpp::LANGUAGE.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .context("load tree-sitter-c/cpp")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    let cpp = matches!(flavor, Flavor::Cpp);
    walk(tree.root_node(), &src, &file, &mut out, &mut symbols, cpp);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
    Ok(out)
}

fn declarator_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    // function_definition / declaration → declarator → function_declarator
    // → identifier. Bound the descent at 6 steps so a pathological grammar
    // can never spin forever.
    let mut cur = node;
    for _ in 0..6 {
        let next = cur
            .child_by_field_name("declarator")
            .or_else(|| cur.child_by_field_name("name"))?;
        if next.kind() == "identifier" || next.kind() == "field_identifier" {
            return next.utf8_text(src.as_bytes()).ok();
        }
        cur = next;
    }
    None
}

fn walk(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
    cpp: bool,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_definition" => {
                if let Some(n) = declarator_name(child, src) {
                    if cpp {
                        let id = format!("{file}::{n}");
                        let sig = cpp_signature(child, src, file, &id, out);
                        emit_def(out, symbols, file, "function", n, child);
                        attach_signature(out, sig);
                    } else {
                        emit_def(out, symbols, file, "function", n, child);
                    }
                }
            }
            "struct_specifier" | "class_specifier" if cpp => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = cpp_field_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child,
                    );
                    attach_signature(out, sig);
                }
            }
            "struct_specifier" | "class_specifier" | "union_specifier" | "enum_specifier" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_specifier"),
                        n,
                        child,
                    );
                }
            }
            "namespace_definition" => {
                // C++ only: `namespace foo { ... }`
                // Use a file-independent canonical id so the same namespace
                // declared across multiple translation units collapses to a
                // single node during graph construction (ensure_node dedupes
                // by id) rather than accumulating ambiguous duplicates.
                if let Some(n) = child
                    .child_by_field_name("name")
                    .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                {
                    let canonical_id = format!("namespace::{n}");
                    out.nodes.push(crate::schema::Node {
                        id: canonical_id.clone(),
                        label: n.to_string(),
                        source_file: Some(file.to_string()),
                        source_location: Some(super::common::line_loc(child)),
                        kind: Some("namespace".to_string()),
                        signature: None,
                    });
                    symbols.insert(n.to_string(), canonical_id);
                }
            }
            "preproc_include" => {
                let path_node = child
                    .child_by_field_name("path")
                    .expect("preproc_include has path field");
                let text = path_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let trimmed = text.trim_matches(|c| matches!(c, '"' | '<' | '>'));
                emit_import(out, file, trimmed, child);
            }
            _ => {}
        }
        walk(child, src, file, out, symbols, cpp);
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
        if child.kind() == "function_definition"
            && let Some(name) = declarator_name(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
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
        if child.kind() == "call_expression"
            && let Some(fn_node) = child.child_by_field_name("function")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
