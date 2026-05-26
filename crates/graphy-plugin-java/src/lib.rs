//! Java language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-java",
    extensions: ["java"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_java::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-java: {e}"))?;
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
        match child.kind() {
            "method_declaration" | "constructor_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                }
            }
            "class_declaration" | "interface_declaration" | "enum_declaration"
            | "record_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "import_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                // Java wildcard `import java.util.*;` lands here intact — `*`
                // survives trim() so dedup::is_glob can later identify it.
                let target = text
                    .trim_start_matches("import")
                    .trim_end_matches(';')
                    .trim();
                emit_import(out, file, target, child.start_position().row);
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
        if matches!(
            child.kind(),
            "method_declaration" | "constructor_declaration"
        )
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
        if child.kind() == "method_invocation"
            && let Some(fn_node) = child.child_by_field_name("name") {
                let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
