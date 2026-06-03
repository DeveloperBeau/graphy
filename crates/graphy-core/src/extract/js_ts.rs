//! JS / TS / TSX extractors. All share the same node kinds via tree-sitter's
//! TypeScript and JavaScript grammars.

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
    Javascript,
    Typescript,
    Tsx,
}

pub fn extract(path: &Path, flavor: Flavor) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let file = path.to_string_lossy().into_owned();
    extract_src(&src, &file, flavor)
}

/// Parse an in-memory source string as JavaScript (without reading from disk).
/// `file_label` is used as the file identifier in emitted node IDs.
pub fn extract_src(src: &str, file_label: &str, flavor: Flavor) -> Result<ExtractionOutput> {
    let lang: Language = match flavor {
        Flavor::Javascript => tree_sitter_javascript::LANGUAGE.into(),
        Flavor::Typescript => tree_sitter_typescript::LANGUAGE_TYPESCRIPT.into(),
        Flavor::Tsx => tree_sitter_typescript::LANGUAGE_TSX.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .context("load tree-sitter language")?;
    let tree = parser
        .parse(src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    walk_defs(tree.root_node(), src, file_label, &mut out, &mut symbols);
    walk_calls(tree.root_node(), src, file_label, &mut out, &symbols);
    Ok(out)
}

fn walk_defs(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut ExtractionOutput,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_declaration" | "generator_function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = ts_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
                }
            }
            "class_declaration"
            | "abstract_class_declaration"
            | "interface_declaration"
            | "type_alias_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    // abstract_class_declaration -> kind="class" (same as class_declaration)
                    let kind = match child.kind() {
                        "abstract_class_declaration" => "class",
                        other => other.trim_end_matches("_declaration"),
                    };
                    let id = format!("{file}::{n}");
                    let sig = ts_class_or_interface_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, kind, n, child);
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
                }
            }
            "method_definition" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = ts_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "method", n, child);
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
                }
            }
            "import_statement" => {
                let source = child
                    .child_by_field_name("source")
                    .expect("import_statement has source field");
                let text = source.utf8_text(src.as_bytes()).expect("utf8 source");
                let module = text.trim_matches(|c| matches!(c, '"' | '\''));
                let names = js_imported_names(child, src, module);
                if names.is_empty() {
                    // Side-effect-only import: `import "./mod"` — keep the module
                    // alone as the extern.
                    emit_import(out, file, module, child);
                } else {
                    for n in names {
                        emit_import(out, file, &n, child);
                    }
                }
            }
            _ => {}
        }
        walk_defs(child, src, file, out, symbols);
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
            "function_declaration"
                | "generator_function_declaration"
                | "method_definition"
                | "arrow_function"
                | "function_expression"
        ) {
            let name = name_of(child, src).unwrap_or("<anon>");
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
    }
}

fn js_imported_names(node: TsNode, src: &str, module: &str) -> Vec<String> {
    let mut out: Vec<String> = Vec::new();
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if c.kind() != "import_clause" {
            continue;
        }
        let mut sub = c.walk();
        for sc in c.children(&mut sub) {
            match sc.kind() {
                "named_imports" => {
                    let raw = sc.utf8_text(src.as_bytes()).unwrap_or("");
                    for name in crate::extract::common::expand_import_paths(raw) {
                        let stripped = name.trim();
                        if !stripped.is_empty() {
                            out.push(format!("{module}/{stripped}"));
                        }
                    }
                }
                "namespace_import" => {
                    // `* as ns`
                    out.push(format!("{module}/*"));
                }
                "identifier" => {
                    // Default import `import Foo from "..."`
                    let raw = sc.utf8_text(src.as_bytes()).unwrap_or("");
                    let stripped = raw.trim();
                    if !stripped.is_empty() {
                        out.push(format!("{module}/{stripped}"));
                    }
                }
                _ => {}
            }
        }
    }
    out
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
        if child.kind() == "call_expression" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call_expression has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

// ---------- Typed signature layer (TypeScript only) ----------
//
// All emission below is gated on the presence of TS-only `type_annotation`
// nodes. JavaScript params are bare `identifier` nodes (no `required_parameter`
// wrapper) and JS class fields are `field_definition` (not
// `public_field_definition`), so these functions produce empty signatures and
// no edges for JS. The conditional `attach_signature` then leaves JS nodes
// byte-identical.

fn sig_is_empty(sig: &Signature) -> bool {
    sig.params.is_empty() && sig.returns.is_none() && sig.fields.is_empty()
}

/// Text of the first named, non-`:` child of a `type_annotation`. For
/// `": Widget"` returns `"Widget"`; for `": number"` returns `"number"`.
fn bare_type_text(type_annotation: TsNode, src: &str) -> Option<String> {
    let mut c = type_annotation.walk();
    type_annotation
        .children(&mut c)
        .find(|ch| ch.is_named())
        .and_then(|ch| ch.utf8_text(src.as_bytes()).ok())
        .map(|s| s.trim().to_string())
}

/// Recursively collect leaf type names (including primitives and stdlib
/// containers). A `generic_type` pushes its BASE name then recurses into each
/// named type argument: `Array<Pair<Foo,Bar>>` -> `[Array, Pair, Foo, Bar]`.
/// Container suppression happens at the emit site via `is_primitive_or_ignored`,
/// not here, so user generics like `Pair` keep their own edge.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" | "predefined_type" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "nested_type_identifier" => {
            // Qualified `ns.Widget` -> trailing segment (last type_identifier).
            let mut c = node.walk();
            if let Some(last) = node
                .children(&mut c)
                .filter(|ch| ch.kind() == "type_identifier")
                .last()
                && let Ok(s) = last.utf8_text(src.as_bytes())
            {
                out.push(s.to_string());
            }
        }
        "generic_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
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
        "type_annotation" | "array_type" | "union_type" | "intersection_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                extract_type_leaves(ch, src, out);
            }
        }
        _ => {}
    }
}

/// Collect type leaves, de-duped order-preservingly (`Pair<Foo,Foo>` -> one
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

/// TypeScript primitive / builtin types and stdlib generic containers that
/// should not produce typed edges. Containers are suppressed so only their
/// inner meaningful type arguments get edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "number"
            | "string"
            | "boolean"
            | "null"
            | "undefined"
            | "void"
            | "never"
            | "any"
            | "unknown"
            | "object"
            | "symbol"
            | "bigint"
            // Stdlib generic containers.
            | "Array"
            | "ReadonlyArray"
            | "Promise"
            | "Map"
            | "Set"
            | "ReadonlyMap"
            | "ReadonlySet"
            | "Record"
            | "Partial"
            | "Readonly"
            | "Required"
            | "Pick"
            | "Omit"
    )
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges.
fn ts_signature(
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
            if !matches!(p.kind(), "required_parameter" | "optional_parameter") {
                continue;
            }
            let name = p
                .child_by_field_name("pattern")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                .map(|s| s.to_string())
                .unwrap_or_else(|| "_".to_string());
            let ty_anno = p.child_by_field_name("type");
            let ty_text = ty_anno.and_then(|t| bare_type_text(t, src));
            if let Some(t) = ty_anno {
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
    if let Some(ret) = decl.child_by_field_name("return_type") {
        sig.returns = bare_type_text(ret, src);
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

/// Build a class/interface `Signature.fields` and emit `has_field` edges.
/// Returns an empty signature for type aliases, enums, and JS classes.
fn ts_class_or_interface_signature(
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
    let member_kind = match body.kind() {
        "class_body" => "public_field_definition",
        "interface_body" => "property_signature",
        _ => return sig,
    };
    let mut cursor = body.walk();
    for member in body.children(&mut cursor) {
        if member.kind() != member_kind {
            continue;
        }
        let Some(name) = member
            .child_by_field_name("name")
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            .map(|s| s.to_string())
        else {
            continue;
        };
        let Some(ty_anno) = member.child_by_field_name("type") else {
            continue;
        };
        let ty_text = bare_type_text(ty_anno, src);
        for leaf in type_leaves(ty_anno, src) {
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
                source_location: Some(line_loc(member)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}
