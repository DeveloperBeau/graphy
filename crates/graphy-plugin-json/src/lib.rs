//! JSON language plugin for graphy.

use core::ffi::{c_char, c_uint};

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

static EXT_JSON: &[u8] = b"json\0";
static EXTENSIONS: graphy_plugin_api::ExtensionTable =
    graphy_plugin_api::ExtensionTable::new(&[EXT_JSON.as_ptr() as *const c_char]);

const NAME: &[u8] = b"graphy-plugin-json\0";
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
/// Bytes must be valid for given lengths.
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
        .set_language(&tree_sitter_json::LANGUAGE.into())
        .is_err()
    {
        return err_result(STATUS_INTERNAL_ERROR, "load tree-sitter-json failed");
    }
    let Some(tree) = parser.parse(source, None) else {
        return err_result(STATUS_INTERNAL_ERROR, "parse returned None");
    };

    let mut out = Output::default();
    walk(tree.root_node(), source, path, &mut out);

    match serde_json::to_vec(&out) {
        Ok(b) => ok_result(b),
        Err(e) => err_result(STATUS_INTERNAL_ERROR, format!("serde: {e}")),
    }
}

#[unsafe(no_mangle)]
pub extern "C" fn graphy_plugin_free(result: GraphyPluginExtractResult) {
    unsafe { release_result(result) }
}

fn walk(node: TsNode, src: &str, file: &str, out: &mut Output) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "pair" {
            let key = child
                .child_by_field_name("key")
                .expect("pair has key field");
            let raw = key.utf8_text(src.as_bytes()).expect("utf8 source");
            let label = raw.trim_matches('"').to_string();
            if !label.is_empty() {
                let id = format!("{file}::{label}");
                out.nodes.push(Node {
                    id: id.clone(),
                    label: label.clone(),
                    source_file: Some(file.to_string()),
                    source_location: Some(format!("L{}", key.start_position().row + 1)),
                    kind: Some("json_key".into()),
                });
                if label == "$ref" {
                    let value = child
                        .child_by_field_name("value")
                        .expect("pair has value field");
                    let v = value.utf8_text(src.as_bytes()).expect("utf8 source");
                    let target = v.trim_matches('"').to_string();
                    if !target.is_empty() {
                        out.edges.push(Edge {
                            source: id,
                            target: format!("ref::{target}"),
                            relation: "references".into(),
                            confidence: "EXTRACTED",
                        });
                    }
                }
            }
        }
        walk(child, src, file, out);
    }
}
