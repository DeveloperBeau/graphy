//! Python extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{attach_signature, emit_call, emit_def, emit_import, line_loc, name_of};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_python::LANGUAGE.into())
        .context("load tree-sitter-python")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");

    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    let mut symbols: HashMap<String, String> = HashMap::new();

    walk_defs(tree.root_node(), &src, &file, &mut out, &mut symbols);
    walk_calls(tree.root_node(), &src, &file, &mut out, &symbols);
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
            "function_definition" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = python_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_definition" => {
                if let Some(n) = name_of(child, src) {
                    let class_id = format!("{file}::{n}");
                    let sig = python_class_signature(child, src, file, &class_id, out);
                    emit_def(out, symbols, file, "class", n, child);
                    attach_signature(out, sig);
                    // Emit `inherits` edge for each base class in the argument_list.
                    let mut cc = child.walk();
                    for gc in child.children(&mut cc) {
                        if gc.kind() == "argument_list" {
                            let mut bc = gc.walk();
                            for base in gc.children(&mut bc) {
                                if base.kind() == "identifier"
                                    && let Ok(base_name) = base.utf8_text(src.as_bytes())
                                {
                                    let base_name = base_name.trim();
                                    if !base_name.is_empty() {
                                        let target_id = format!("extern::{base_name}");
                                        out.edges.push(Edge {
                                            source: class_id.clone(),
                                            target: target_id,
                                            relation: "inherits".into(),
                                            confidence: Confidence::Extracted,
                                            attr: None,
                                        });
                                    }
                                }
                            }
                        }
                    }
                }
            }
            "import_statement" | "import_from_statement" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let cleaned = text.trim();
                let (module, names_raw): (String, Option<String>) =
                    if let Some(rest) = cleaned.strip_prefix("from ") {
                        if let Some((m, n)) = rest.split_once(" import ") {
                            (m.trim().to_string(), Some(n.trim().to_string()))
                        } else {
                            (rest.trim().to_string(), None)
                        }
                    } else if let Some(rest) = cleaned.strip_prefix("import ") {
                        // `import a, b, c` — expand each as its own top-level module.
                        (String::new(), Some(rest.trim().to_string()))
                    } else {
                        (cleaned.to_string(), None)
                    };
                let brace_form = if let Some(ref n) = names_raw {
                    format!("{{{n}}}")
                } else {
                    module.clone()
                };
                for path in crate::extract::common::expand_import_paths(&brace_form) {
                    if path.is_empty() {
                        continue;
                    }
                    // Convert the leaf path from ::- to dot-separated form, then
                    // join it with the module using a single dot separator.
                    // This avoids the double-dot problem: `from . import helper`
                    // would become `..helper` if we naively replaced `::` globally
                    // on a normalised string like `.::helper`.
                    let leaf = path.replace("::", ".");
                    let label = if !module.is_empty() {
                        if module.ends_with('.') {
                            // module is already a trailing-dot relative prefix (e.g. "..", ".")
                            format!("{module}{leaf}")
                        } else {
                            format!("{module}.{leaf}")
                        }
                    } else {
                        leaf
                    };
                    emit_import(out, file, &label, child);
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
        if child.kind() == "function_definition"
            && let Some(name) = name_of(child, src)
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
        if child.kind() == "call" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

/// Collect the outer type name and every generic inner-argument name from a
/// Python `type` annotation node, depth first. `List[Pair[Foo, Bar]]` ->
/// ["List", "Pair", "Foo", "Bar"].
fn extract_type_leaves<'a>(node: TsNode<'a>, src: &'a str, out: &mut Vec<String>) {
    match node.kind() {
        "identifier" => {
            if let Ok(t) = node.utf8_text(src.as_bytes()) {
                out.push(t.to_string());
            }
        }
        "attribute" => {
            // Dotted base like `typing.List` — keep the trailing name only.
            if let Ok(t) = node.utf8_text(src.as_bytes()) {
                out.push(t.rsplit('.').next().unwrap_or(t).to_string());
            }
        }
        "type" | "generic_type" | "type_parameter" | "subscript" => {
            let mut c = node.walk();
            for child in node.children(&mut c) {
                if child.is_named() {
                    extract_type_leaves(child, src, out);
                }
            }
        }
        _ => {}
    }
}

/// `extract_type_leaves` plus order-preserving de-duplication, so one type
/// produces at most one edge per position.
fn type_leaves<'a>(node: TsNode<'a>, src: &'a str) -> Vec<String> {
    let mut v = Vec::new();
    extract_type_leaves(node, src, &mut v);
    let mut seen = std::collections::HashSet::new();
    v.retain(|x| seen.insert(x.clone()));
    v
}

/// Python builtins / typing names that should not produce typed edges.
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "int"
            | "str"
            | "float"
            | "bool"
            | "bytes"
            | "bytearray"
            | "complex"
            | "None"
            | "object"
            | "Any"
            | "list"
            | "dict"
            | "set"
            | "tuple"
            | "frozenset"
            | "type"
            | "List"
            | "Dict"
            | "Set"
            | "Tuple"
            | "FrozenSet"
            | "Optional"
            | "Union"
            | "Sequence"
            | "Iterable"
            | "Mapping"
            | "Awaitable"
    )
}

/// The declared name of a parameter node (handles typed/default forms).
fn param_name<'s>(p: TsNode, src: &'s str) -> Option<&'s str> {
    if let Some(n) = p.child_by_field_name("name") {
        return n.utf8_text(src.as_bytes()).ok();
    }
    if p.kind() == "identifier" {
        return p.utf8_text(src.as_bytes()).ok();
    }
    let mut c = p.walk();
    p.children(&mut c)
        .find(|ch| ch.kind() == "identifier")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges
/// for annotated, non-primitive types. Every parameter appears in the payload;
/// `ty` is the annotation text or `None`. `self`/`cls` are skipped and not counted.
fn python_signature(
    fn_node: TsNode,
    src: &str,
    file: &str,
    fn_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = fn_node.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if !matches!(
                p.kind(),
                "identifier" | "typed_parameter" | "default_parameter" | "typed_default_parameter"
            ) {
                continue;
            }
            let Some(name) = param_name(p, src).map(|s| s.to_string()) else {
                continue;
            };
            if name == "self" || name == "cls" {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            if let Some(ty_node) = ty_node {
                for leaf in type_leaves(ty_node, src) {
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
    if let Some(ret) = fn_node.child_by_field_name("return_type") {
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

/// Build a class `Signature.fields` from annotated class attributes and emit
/// `has_field` edges for non-primitive annotated types.
fn python_class_signature(
    class_node: TsNode,
    src: &str,
    file: &str,
    class_id: &str,
    out: &mut ExtractionOutput,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = class_node.child_by_field_name("body") else {
        return sig;
    };
    let mut cursor = body.walk();
    for stmt in body.children(&mut cursor) {
        if stmt.kind() != "expression_statement" {
            continue;
        }
        let mut sc = stmt.walk();
        let Some(assign) = stmt.children(&mut sc).find(|c| c.kind() == "assignment") else {
            continue;
        };
        let Some(ty_node) = assign.child_by_field_name("type") else {
            continue;
        };
        let Some(name) = assign
            .child_by_field_name("left")
            .and_then(|l| l.utf8_text(src.as_bytes()).ok())
            .map(|s| s.to_string())
        else {
            continue;
        };
        let ty_text = ty_node
            .utf8_text(src.as_bytes())
            .ok()
            .map(|s| s.trim().to_string());
        for leaf in type_leaves(ty_node, src) {
            if is_primitive_or_ignored(&leaf) {
                continue;
            }
            out.edges.push(Edge {
                source: class_id.to_string(),
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
                source_location: Some(line_loc(stmt)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}
