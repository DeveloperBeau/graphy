//! JavaScript / TypeScript / TSX language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{Output, emit_call, emit_def, emit_import};
use tree_sitter::{Language, Node as TsNode, Parser};

graphy_plugin_api::define_plugin! {
    name: "graphy-plugin-js-ts",
    extensions: ["js", "jsx", "mjs", "cjs", "ejs", "ts", "tsx"],
    extract_json: extract_to_json,
}

fn extract_to_json(path: &str, source: &str) -> Result<Vec<u8>, String> {
    let ext = path
        .rsplit('.')
        .next()
        .map(|s| s.to_ascii_lowercase())
        .unwrap_or_default();
    let lang: Language = match ext.as_str() {
        "ts" => tree_sitter_typescript::LANGUAGE_TYPESCRIPT.into(),
        "tsx" => tree_sitter_typescript::LANGUAGE_TSX.into(),
        _ => tree_sitter_javascript::LANGUAGE.into(),
    };
    let mut parser = Parser::new();
    parser
        .set_language(&lang)
        .map_err(|e| format!("load tree-sitter language: {e}"))?;
    let tree = parser
        .parse(source, None)
        .ok_or_else(|| "parse returned None".to_string())?;
    let mut out = Output::default();
    let mut symbols: HashMap<String, String> = HashMap::new();
    walk_defs(tree.root_node(), source, path, &mut out, &mut symbols);
    walk_calls(tree.root_node(), source, path, &mut out, &symbols);
    serde_json::to_vec(&out).map_err(|e| e.to_string())
}

fn name_of<'src>(node: TsNode, src: &'src str) -> Option<&'src str> {
    node.child_by_field_name("name")
        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
}

fn walk_defs(
    node: TsNode,
    src: &str,
    file: &str,
    out: &mut Output,
    symbols: &mut HashMap<String, String>,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        match child.kind() {
            "function_declaration" | "generator_function_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(
                        out,
                        symbols,
                        file,
                        "function",
                        n,
                        child.start_position().row,
                    );
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "type_alias_declaration"
            | "enum_declaration" => {
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
            "method_definition" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                }
            }
            "import_statement" => {
                let source_node = child
                    .child_by_field_name("source")
                    .expect("import_statement has source field");
                let text = source_node.utf8_text(src.as_bytes()).expect("utf8 source");
                let module = text.trim_matches(|c| matches!(c, '"' | '\''));
                let names = js_imported_names(child, src, module);
                if names.is_empty() {
                    // Side-effect-only import: `import "./mod"` — keep the
                    // module alone as the extern.
                    emit_import(out, file, module, child.start_position().row);
                } else {
                    for n in names {
                        emit_import(out, file, &n, child.start_position().row);
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
    out: &mut Output,
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

fn collect_calls(
    node: TsNode,
    src: &str,
    caller_id: &str,
    out: &mut Output,
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

/// Walk an `import_statement` node's `import_clause` to collect the names
/// being imported, returning them as `"<module>/<name>"` strings.
/// Returns an empty Vec for side-effect-only imports (`import "./mod"`).
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
                    for name in expand_import_paths(raw) {
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
                    // Default import: `import Foo from "..."`
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
