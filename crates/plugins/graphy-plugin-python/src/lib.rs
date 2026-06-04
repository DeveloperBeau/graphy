//! Python language plugin for graphy.

use core::ffi::c_char;
use std::collections::HashMap;

use graphy_plugin_api::{
    ABI_VERSION, GraphyPluginExtractResult, GraphyPluginMetadata, STATUS_INTERNAL_ERROR,
    err_result, ok_result, release_result,
};
use serde::Serialize;
use tree_sitter::{Node as TsNode, Parser};

#[derive(Serialize, Default)]
struct Output {
    nodes: Vec<Node>,
    edges: Vec<Edge>,
}

#[derive(Serialize)]
struct Node {
    id: String,
    label: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    source_file: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    source_location: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    kind: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    signature: Option<Signature>,
}

#[derive(Serialize)]
struct Edge {
    source: String,
    target: String,
    relation: String,
    confidence: &'static str,
    #[serde(skip_serializing_if = "Option::is_none")]
    attr: Option<EdgeAttr>,
}

#[derive(Serialize, Default)]
struct Signature {
    #[serde(skip_serializing_if = "Vec::is_empty")]
    params: Vec<ParamSig>,
    #[serde(skip_serializing_if = "Option::is_none")]
    returns: Option<String>,
    #[serde(skip_serializing_if = "Vec::is_empty")]
    fields: Vec<FieldSig>,
}

#[derive(Serialize)]
struct ParamSig {
    name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    ty: Option<String>,
}

#[derive(Serialize)]
struct FieldSig {
    name: String,
    #[serde(skip_serializing_if = "Option::is_none")]
    ty: Option<String>,
}

#[derive(Serialize)]
struct EdgeAttr {
    #[serde(skip_serializing_if = "Option::is_none")]
    name: Option<String>,
    #[serde(skip_serializing_if = "Option::is_none")]
    index: Option<u32>,
}

#[unsafe(no_mangle)]
pub extern "C" fn graphy_plugin_abi_version() -> u32 {
    ABI_VERSION
}

static EXT_PY: &[u8] = b"py\0";
static EXTENSIONS: graphy_plugin_api::ExtensionTable =
    graphy_plugin_api::ExtensionTable::new(&[EXT_PY.as_ptr() as *const c_char]);

const NAME: &[u8] = b"graphy-plugin-python\0";
const VERSION: &[u8] = concat!(env!("CARGO_PKG_VERSION"), "\0").as_bytes();

static META: GraphyPluginMetadata = GraphyPluginMetadata {
    name: NAME.as_ptr() as *const c_char,
    version: VERSION.as_ptr() as *const c_char,
    extensions: EXTENSIONS.as_ptr(),
    extension_count: EXTENSIONS.len(),
};

#[unsafe(no_mangle)]
pub extern "C" fn graphy_plugin_metadata() -> *const GraphyPluginMetadata {
    &META
}

/// # Safety
/// `path_utf8`, `src` must be valid for `path_len` / `src_len` bytes.
#[unsafe(no_mangle)]
pub unsafe extern "C" fn graphy_plugin_extract(
    path_utf8: *const c_char,
    path_len: usize,
    src: *const u8,
    src_len: usize,
) -> GraphyPluginExtractResult {
    let path_bytes = unsafe { std::slice::from_raw_parts(path_utf8 as *const u8, path_len) };
    let Ok(path) = std::str::from_utf8(path_bytes) else {
        return err_result(STATUS_INTERNAL_ERROR, "path not utf-8");
    };
    let src_bytes = unsafe { std::slice::from_raw_parts(src, src_len) };
    let Ok(source) = std::str::from_utf8(src_bytes) else {
        return err_result(STATUS_INTERNAL_ERROR, "source not utf-8");
    };
    match extract_to_json(path, source) {
        Ok(b) => ok_result(b),
        Err(e) => err_result(STATUS_INTERNAL_ERROR, e),
    }
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_python::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-python: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

#[unsafe(no_mangle)]
pub extern "C" fn graphy_plugin_free(result: GraphyPluginExtractResult) {
    unsafe { release_result(result) }
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn line_loc(node: TsNode) -> String {
    format!("L{}", node.start_position().row + 1)
}

fn attach_signature(out: &mut Output, sig: Signature) {
    if let Some(n) = out.nodes.last_mut() {
        n.signature = Some(sig);
    }
}

fn emit_def(
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
    file: &str,
    kind: &str,
    name: &str,
    node: TsNode,
) {
    let id = format!("{file}::{name}");
    symbols.insert(name.to_string(), id.clone());
    out.nodes.push(Node {
        id,
        label: name.to_string(),
        source_file: Some(file.to_string()),
        source_location: Some(line_loc(node)),
        kind: Some(kind.to_string()),
        signature: None,
    });
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
                let row = child.start_position().row;
                for path in expand_import_paths(&brace_form) {
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
                            format!("{module}{leaf}")
                        } else {
                            format!("{module}.{leaf}")
                        }
                    } else {
                        leaf
                    };
                    let import_id = format!("extern::{label}");
                    out.nodes.push(Node {
                        id: import_id.clone(),
                        label,
                        source_file: Some(file.to_string()),
                        source_location: Some(format!("L{}", row + 1)),
                        kind: Some("import".into()),
                        signature: None,
                    });
                    out.edges.push(Edge {
                        source: file.to_string(),
                        target: import_id,
                        relation: "imports".into(),
                        confidence: "EXTRACTED",
                        attr: None,
                    });
                }
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
    out: &mut Output,
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
    out: &mut Output,
    symbols: &HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "call" {
            let fn_node = child
                .child_by_field_name("function")
                .expect("call has function field");
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            let leaf = text.rsplit(['.', ':', ' ']).next().unwrap_or(text);
            if let Some(target_id) = symbols.get(leaf) {
                out.edges.push(Edge {
                    source: caller_id.to_string(),
                    target: target_id.clone(),
                    relation: "calls".into(),
                    confidence: "INFERRED",
                    attr: None,
                });
            }
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
    out: &mut Output,
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
                        confidence: "EXTRACTED",
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
                confidence: "EXTRACTED",
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
    out: &mut Output,
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
                confidence: "EXTRACTED",
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

/// Expand an import path that may contain brace groups into individual
/// fully-qualified paths. Copied from `graphy_core::extract::common`.
fn expand_import_paths(raw: &str) -> Vec<String> {
    let raw = raw.trim();
    if !raw.contains('{') {
        return vec![raw.to_string()];
    }
    let Some(open) = raw.find('{') else {
        return vec![raw.to_string()];
    };
    let prefix = raw[..open].trim_end_matches(':').to_string();
    let prefix_with_sep = if prefix.is_empty() {
        String::new()
    } else {
        format!("{prefix}::")
    };
    let body_start = open + 1;
    let mut depth = 1usize;
    let mut end = body_start;
    for (i, c) in raw[body_start..].char_indices() {
        match c {
            '{' => depth += 1,
            '}' => {
                depth -= 1;
                if depth == 0 {
                    end = body_start + i;
                    break;
                }
            }
            _ => {}
        }
    }
    if depth != 0 {
        return vec![raw.to_string()];
    }
    let body = &raw[body_start..end];
    let mut parts: Vec<String> = Vec::new();
    let mut buf = String::new();
    let mut local_depth = 0usize;
    for c in body.chars() {
        match c {
            '{' => {
                local_depth += 1;
                buf.push(c);
            }
            '}' => {
                local_depth -= 1;
                buf.push(c);
            }
            ',' if local_depth == 0 => {
                let piece = buf.trim();
                if !piece.is_empty() {
                    parts.push(piece.to_string());
                }
                buf.clear();
            }
            _ => buf.push(c),
        }
    }
    let last = buf.trim();
    if !last.is_empty() {
        parts.push(last.to_string());
    }
    let mut out: Vec<String> = Vec::new();
    for part in parts {
        let trimmed = part.split(" as ").next().unwrap_or(part.as_str()).trim();
        if trimmed.contains('{') {
            for nested in expand_import_paths(trimmed) {
                out.push(format!("{prefix_with_sep}{nested}"));
            }
        } else {
            out.push(format!("{prefix_with_sep}{trimmed}"));
        }
    }
    out
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.py", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_partial_typed_layer() {
        let v = extract(
            "class Svc:\n    w: Widget\n    def do(self, x: Widget, n: int) -> Widget:\n        return x\n\ndef build(w: Widget, untyped) -> Widget:\n    return w\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param" && e["source"] == "s.py::build")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "w");
        assert_eq!(hp["attr"]["index"], 0);

        assert!(edges.iter().any(|e| e["relation"] == "has_field"
            && e["source"] == "s.py::Svc"
            && e["attr"]["name"] == "w"));
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );

        let build = nodes.iter().find(|n| n["id"] == "s.py::build").unwrap();
        let params = build["signature"]["params"].as_array().unwrap();
        assert_eq!(params.len(), 2);
        assert_eq!(params[1]["name"], "untyped");
        assert!(params[1].get("ty").is_none() || params[1]["ty"].is_null());
    }
}
