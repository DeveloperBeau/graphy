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
}

#[derive(Serialize)]
struct Edge {
    source: String,
    target: String,
    relation: String,
    confidence: &'static str,
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

    let mut parser = Parser::new();
    if parser
        .set_language(&tree_sitter_python::LANGUAGE.into())
        .is_err()
    {
        return err_result(STATUS_INTERNAL_ERROR, "load tree-sitter-python failed");
    }
    let Some(tree) = parser.parse(source, None) else {
        return err_result(STATUS_INTERNAL_ERROR, "parse returned None");
    };

    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);

    match serde_json::to_vec(&out) {
        Ok(b) => ok_result(b),
        Err(e) => err_result(STATUS_INTERNAL_ERROR, format!("serde: {e}")),
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn graphy_plugin_free(result: GraphyPluginExtractResult) {
    unsafe { release_result(result) }
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
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
        source_location: Some(format!("L{}", node.start_position().row + 1)),
        kind: Some(kind.to_string()),
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
                    emit_def(out, symbols, file, "function", n, child);
                }
            }
            "class_definition" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "class", n, child);
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
                    });
                    out.edges.push(Edge {
                        source: file.to_string(),
                        target: import_id,
                        relation: "imports".into(),
                        confidence: "EXTRACTED",
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
            && let Some(name) = name_of(child, src) {
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
            let leaf = text
                .rsplit(['.', ':', ' '])
                .next()
                .unwrap_or(text);
            if let Some(target_id) = symbols.get(leaf) {
                out.edges.push(Edge {
                    source: caller_id.to_string(),
                    target: target_id.clone(),
                    relation: "calls".into(),
                    confidence: "INFERRED",
                });
            }
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
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
    let prefix_with_sep = if prefix.is_empty() { String::new() } else { format!("{prefix}::") };
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
            '{' => { local_depth += 1; buf.push(c); }
            '}' => { local_depth -= 1; buf.push(c); }
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
