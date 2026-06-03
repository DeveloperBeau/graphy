//! Bash language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-bash",
    extensions: ["sh", "bash"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_bash::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-bash: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
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
        if child.kind() == "function_definition"
            && let Some(n) = name_of(child, src)
        {
            emit_def(
                out,
                symbols,
                file,
                "function",
                n,
                child.start_position().row,
            );
        }
        if child.kind() == "command" {
            // `source path/to/x.sh` or `. path/to/x.sh`
            let name = child
                .child_by_field_name("name")
                .expect("command has name field");
            let cmd = name.utf8_text(src.as_bytes()).expect("utf8 source");
            if matches!(cmd, "source" | ".") {
                let mut subc = child.walk();
                if let Some(a) = child.children_by_field_name("argument", &mut subc).next() {
                    let text = a.utf8_text(src.as_bytes()).expect("utf8 source");
                    emit_import(out, file, text, child.start_position().row);
                }
            }
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
        if child.kind() == "command" {
            let name = child
                .child_by_field_name("name")
                .expect("command has name field");
            let text = name.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    // Bash has no parameter list in its grammar (positional `$1`), so the
    // typed signature layer is "none": no signature payload, no typed edges,
    // no kind:"type" nodes. This mirrors the built-in extractor.
    #[test]
    fn emits_no_typed_signature_layer() {
        let src = "format_name() {\n  local name=\"$1\"\n  echo \"$name\"\n}\n";
        let bytes = extract_to_json("a.sh", src).unwrap();
        let v: Value = serde_json::from_slice(&bytes).unwrap();

        let nodes = v["nodes"].as_array().unwrap();
        assert!(
            nodes
                .iter()
                .any(|n| n["label"] == "format_name" && n["kind"] == "function"),
            "expected function node: {nodes:#?}"
        );
        for n in nodes {
            assert!(
                n.get("signature").is_none() || n["signature"].is_null(),
                "node carries signature: {n}"
            );
            assert_ne!(n["kind"], "type", "unexpected kind:\"type\" node: {n}");
        }
        for e in v["edges"].as_array().unwrap() {
            let rel = e["relation"].as_str().unwrap_or("");
            assert!(
                !matches!(rel, "has_param" | "returns" | "has_field"),
                "unexpected typed edge: {e}"
            );
        }
    }
}
