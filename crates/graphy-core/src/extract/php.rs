//! PHP extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{
    attach_signature, emit_call, emit_def, emit_import, emit_inherits, line_loc, name_of,
};
use crate::schema::{
    Confidence, Edge, EdgeAttr, ExtractionOutput, FieldSig, Node, ParamSig, Signature,
};

/// PHP keywords that are types but never reference a user-defined symbol.
/// `primitive_type` grammar nodes already short-circuit in `extract_type_leaf`;
/// this catches the keywords the grammar wraps in `named_type`
/// (`void`, `never`, `self`, `static`, `parent`).
fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "int"
            | "string"
            | "float"
            | "bool"
            | "void"
            | "mixed"
            | "array"
            | "object"
            | "callable"
            | "iterable"
            | "null"
            | "never"
            | "false"
            | "true"
            | "self"
            | "static"
            | "parent"
    )
}

/// Extract the leaf type name from a PHP type node, or `None` for primitives
/// and grammar positions that carry no user-defined type.
fn extract_type_leaf(node: TsNode, src: &str) -> Option<String> {
    match node.kind() {
        // `primitive_type` (int, string, array, callable, ...) is never a
        // user-defined symbol.
        "primitive_type" => None,
        // `?Widget` wraps the inner `named_type`.
        "optional_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
        "named_type" => {
            let mut c = node.walk();
            node.children(&mut c)
                .find_map(|ch| extract_type_leaf(ch, src))
        }
        "name" => node.utf8_text(src.as_bytes()).ok().map(|s| s.to_string()),
        // `\App\Widget` -> last `name` segment.
        "qualified_name" => node
            .utf8_text(src.as_bytes())
            .ok()
            .and_then(|s| s.rsplit('\\').next().map(|x| x.to_string())),
        _ => None,
    }
}

/// Strip the leading `$` from a PHP `variable_name` so payload names read
/// `w` rather than `$w`.
fn param_name(node: TsNode, src: &str) -> Option<String> {
    node.utf8_text(src.as_bytes())
        .ok()
        .map(|s| s.trim_start_matches('$').to_string())
}

/// Build a function/method `Signature` and emit `has_param` / `returns` edges
/// plus the referenced `extern::<Type>` type nodes. PHP types are optional:
/// every parameter lands in `sig.params` with its name and `ty` (the annotation
/// text or `None`); a `has_param` edge + type node fire only when an annotation
/// is present and its leaf is non-primitive. `index` counts all parameters.
fn php_signature(
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
            if !matches!(
                p.kind(),
                "simple_parameter" | "variadic_parameter" | "property_promotion_parameter"
            ) {
                continue;
            }
            let ty_node = p.child_by_field_name("type");
            let ty_text = ty_node
                .and_then(|t| t.utf8_text(src.as_bytes()).ok())
                .map(|s| s.trim().to_string());
            let leaf = ty_node
                .and_then(|t| extract_type_leaf(t, src))
                .filter(|l| !is_primitive_or_ignored(l));
            let name = p
                .child_by_field_name("name")
                .and_then(|n| param_name(n, src))
                .unwrap_or_else(|| "_".to_string());
            if let Some(ref leaf) = leaf {
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
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    if let Some(ret) = decl.child_by_field_name("return_type") {
        if let Ok(text) = ret.utf8_text(src.as_bytes()) {
            sig.returns = Some(text.trim().to_string());
        }
        if let Some(leaf) = extract_type_leaf(ret, src).filter(|l| !is_primitive_or_ignored(l)) {
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

/// Build a class `Signature.fields` from typed `property_declaration` members
/// and emit `has_field` edges for non-primitive field types.
fn php_class_signature(
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
    for member in body.children(&mut cursor) {
        if member.kind() != "property_declaration" {
            continue;
        }
        let ty_node = member.child_by_field_name("type");
        let ty_text = ty_node
            .and_then(|t| t.utf8_text(src.as_bytes()).ok())
            .map(|s| s.trim().to_string());
        let leaf = ty_node
            .and_then(|t| extract_type_leaf(t, src))
            .filter(|l| !is_primitive_or_ignored(l));
        // `property_element` -> field `name` -> `variable_name` ($item).
        let mut pc = member.walk();
        let Some(name) = member
            .children(&mut pc)
            .find(|c| c.kind() == "property_element")
            .and_then(|el| el.child_by_field_name("name"))
            .and_then(|n| param_name(n, src))
        else {
            continue;
        };
        if let Some(leaf) = &leaf {
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

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_php::LANGUAGE_PHP.into())
        .context("load tree-sitter-php")?;
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
            "function_definition" | "method_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = php_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "function", n, child);
                    attach_signature(out, sig);
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "trait_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let child_id = format!("{file}::{n}");
                    let sig = php_class_signature(child, src, file, &child_id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child,
                    );
                    attach_signature(out, sig);
                    // Emit inherits/implements edges from base_clause and class_interface_clause.
                    let mut ec = child.walk();
                    for gc in child.children(&mut ec) {
                        match gc.kind() {
                            "base_clause" => {
                                // base_clause -> name (first `name` child is the parent class)
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if (item.kind() == "name" || item.kind() == "qualified_name")
                                        && let Ok(parent) = item.utf8_text(src.as_bytes())
                                    {
                                        emit_inherits(out, &child_id, parent, "inherits", item);
                                        break;
                                    }
                                }
                            }
                            "class_interface_clause" => {
                                // class_interface_clause -> name nodes (interfaces)
                                let mut gc2 = gc.walk();
                                for item in gc.children(&mut gc2) {
                                    if (item.kind() == "name" || item.kind() == "qualified_name")
                                        && let Ok(parent) = item.utf8_text(src.as_bytes())
                                    {
                                        emit_inherits(out, &child_id, parent, "implements", item);
                                    }
                                }
                            }
                            _ => {}
                        }
                    }
                }
            }
            "namespace_use_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                let target = text.trim_start_matches("use").trim_end_matches(';').trim();
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
        if matches!(child.kind(), "function_definition" | "method_declaration")
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
        if matches!(
            child.kind(),
            "function_call_expression" | "member_call_expression" | "scoped_call_expression"
        ) && let Some(fn_node) = child
            .child_by_field_name("function")
            .or_else(|| child.child_by_field_name("name"))
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
