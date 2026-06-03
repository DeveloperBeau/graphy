//! Ruby language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    Output, ParamSig, Signature, attach_signature, emit_call, emit_def, emit_import,
};
use tree_sitter::{Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-ruby",
    extensions: ["rb"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_ruby::LANGUAGE.into())
        .map_err(|e| format!("load tree-sitter-ruby: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn ruby_name<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = node.walk();
    for c in node.children(&mut cursor) {
        if matches!(c.kind(), "identifier" | "constant" | "scope_resolution") {
            return c.utf8_text(src.as_bytes()).ok();
        }
    }
    None
}

/// Build a NAME-ONLY signature for a method / singleton_method. Ruby's grammar
/// carries no type annotations, so every parameter is `{name, ty: None}` and
/// `returns` / `fields` stay empty. Mirrors the built-in extractor.
fn ruby_signature(decl: TsNode, src: &str) -> Signature {
    let mut sig = Signature::default();
    let Some(params) = decl.child_by_field_name("parameters") else {
        return sig;
    };
    let mut cursor = params.walk();
    for p in params.children(&mut cursor) {
        let name = match p.kind() {
            "identifier" => p.utf8_text(src.as_bytes()).ok(),
            "(" | ")" | "," => None,
            _ => p
                .child_by_field_name("name")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok()),
        };
        if let Some(name) = name {
            sig.params.push(ParamSig {
                name: name.to_string(),
                ty: None,
            });
        }
    }
    sig
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
            "method" | "singleton_method" => {
                if let Some(n) = ruby_name(child, src) {
                    let sig = ruby_signature(child, src);
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                    attach_signature(out, sig);
                }
            }
            "class" | "module" => {
                if let Some(n) = ruby_name(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind(),
                        n,
                        child.start_position().row,
                    );
                }
            }
            "call" => {
                let method = child
                    .child_by_field_name("method")
                    .expect("call node has method field");
                let m = method.utf8_text(src.as_bytes()).expect("utf8 source");
                if matches!(m, "require" | "require_relative" | "load") {
                    let args = child
                        .child_by_field_name("arguments")
                        .expect("require call has arguments field");
                    let text = args.utf8_text(src.as_bytes()).expect("utf8 source");
                    let trimmed = text
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
        if matches!(child.kind(), "method" | "singleton_method")
            && let Some(name) = ruby_name(child, src)
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
        match child.kind() {
            "call" => {
                let method = child
                    .child_by_field_name("method")
                    .expect("call node has method field");
                let text = method.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
            "identifier" => {
                // Bare-identifier statement inside a method body is a method
                // call in Ruby. We only attribute it when the identifier
                // resolves to a defined symbol; otherwise it might be a local.
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                emit_call(out, symbols, caller_id, text);
            }
            _ => {}
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(src: &str) -> Value {
        let bytes = extract_to_json("s.rb", src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn name_only_signature_no_typed_edges_or_nodes() {
        let v = extract(
            "def greet(name, greeting = \"hi\")\n  name\nend\n\n\
             class C\n  def run(a, b)\n    a\n  end\nend\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let nodes = v["nodes"].as_array().unwrap();

        // Parameter names captured with ty absent (null / omitted).
        let greet = nodes.iter().find(|n| n["id"] == "s.rb::greet").unwrap();
        let params = greet["signature"]["params"].as_array().unwrap();
        let pnames: Vec<&str> = params.iter().map(|p| p["name"].as_str().unwrap()).collect();
        assert_eq!(pnames, vec!["name", "greeting"]);
        assert!(params.iter().all(|p| p["ty"].is_null()));
        assert!(greet["signature"]["returns"].is_null());

        let run = nodes.iter().find(|n| n["id"] == "s.rb::run").unwrap();
        let rnames: Vec<&str> = run["signature"]["params"]
            .as_array()
            .unwrap()
            .iter()
            .map(|p| p["name"].as_str().unwrap())
            .collect();
        assert_eq!(rnames, vec!["a", "b"]);

        // NAME-ONLY: no typed edges and no kind:"type" nodes.
        for rel in ["has_param", "returns", "has_field"] {
            assert!(
                !edges.iter().any(|e| e["relation"] == rel),
                "unexpected {rel} edge in NAME-ONLY output"
            );
        }
        assert!(
            !nodes.iter().any(|n| n["kind"] == "type"),
            "unexpected kind:type node in NAME-ONLY output"
        );
    }
}
