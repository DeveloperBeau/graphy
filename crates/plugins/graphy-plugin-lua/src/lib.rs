//! Lua language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    Output, ParamSig, Signature, attach_signature, emit_call, emit_def, emit_import,
};
use tree_sitter::{Node as TsNode, Parser};

/// Build a name-only `Signature` for a Lua function/method. Lua's grammar
/// carries no type annotations, so each parameter contributes a `ParamSig`
/// with `ty: None`; no `returns` and no `fields`.
fn lua_signature(decl: TsNode, src: &str) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        for p in params.children(&mut cursor) {
            if p.kind() != "identifier" {
                continue;
            }
            if let Ok(name) = p.utf8_text(src.as_bytes()) {
                sig.params.push(ParamSig {
                    name: name.to_string(),
                    ty: None,
                });
            }
        }
    }
    sig
}

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-lua",
    extensions: ["lua", "luau"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_lua::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-lua: {e}"))?;
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
            "function_declaration" | "function_definition" | "local_function" => {
                if let Some(n) = name_of(child, src) {
                    let sig = lua_signature(child, src);
                    emit_def(
                        out,
                        symbols,
                        file,
                        "function",
                        n,
                        child.start_position().row,
                    );
                    attach_signature(out, sig);
                }
            }
            "function_call" => {
                // top-level require()
                if let Some(fn_node) = child.child_by_field_name("name")
                    && let Ok(text) = fn_node.utf8_text(src.as_bytes())
                    && text == "require"
                    && let Some(args) = child.child_by_field_name("arguments")
                    && let Ok(arg_text) = args.utf8_text(src.as_bytes())
                {
                    let trimmed = arg_text
                        .trim_matches(|c: char| matches!(c, '(' | ')' | ' '))
                        .trim_matches(|c| matches!(c, '"' | '\''));
                    emit_import(out, file, trimmed, child.start_position().row);
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
        if matches!(
            child.kind(),
            "function_declaration" | "function_definition" | "local_function"
        ) {
            let name = name_of(child, src).unwrap_or("<anon>");
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
        if child.kind() == "function_call"
            && let Some(fn_node) = child.child_by_field_name("name")
            && let Ok(text) = fn_node.utf8_text(src.as_bytes())
        {
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.lua", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_name_only_signature_layer() {
        let v = extract(
            "function M.new_state(name, opts)\n  return name\nend\n\
             function Service:run(mode)\n  return mode\nend\n",
        );
        let nodes = v["nodes"].as_array().unwrap();
        let edges = v["edges"].as_array().unwrap();

        // Function-with-params carries parameter names, all with ty absent.
        let new_state = nodes
            .iter()
            .find(|n| n["label"] == "M.new_state")
            .expect("new_state node");
        let params = new_state["signature"]["params"].as_array().unwrap();
        let names: Vec<&str> = params.iter().map(|p| p["name"].as_str().unwrap()).collect();
        assert_eq!(names, ["name", "opts"]);
        assert!(
            params
                .iter()
                .all(|p| p.get("ty").is_none() || p["ty"].is_null())
        );
        assert!(new_state["signature"].get("returns").is_none());
        assert!(new_state["signature"].get("fields").is_none());

        // Method-with-params likewise.
        let run = nodes
            .iter()
            .find(|n| n["label"] == "Service:run")
            .expect("run node");
        let run_params = run["signature"]["params"].as_array().unwrap();
        let run_names: Vec<&str> = run_params
            .iter()
            .map(|p| p["name"].as_str().unwrap())
            .collect();
        assert_eq!(run_names, ["mode"]);

        // Name-only: no typed edges, no kind:"type" nodes.
        assert!(!edges.iter().any(|e| matches!(
            e["relation"].as_str(),
            Some("has_param") | Some("returns") | Some("has_field")
        )));
        assert!(!nodes.iter().any(|n| n["kind"] == "type"));
    }
}
