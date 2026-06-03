//! JavaScript / TypeScript / TSX language plugin for graphy.

use std::collections::HashMap;

use graphy_plugin_api::helpers::{
    EXTRACTED, Edge, EdgeAttr, FieldSig, Node, Output, ParamSig, Signature, attach_signature,
    emit_call, emit_def, emit_import, line_loc,
};
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
                    let id = format!("{file}::{n}");
                    let sig = ts_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        "function",
                        n,
                        child.start_position().row,
                    );
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "type_alias_declaration"
            | "enum_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = ts_class_or_interface_signature(child, src, file, &id, out);
                    emit_def(
                        out,
                        symbols,
                        file,
                        child.kind().trim_end_matches("_declaration"),
                        n,
                        child.start_position().row,
                    );
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
                }
            }
            "method_definition" => {
                if let Some(n) = name_of(child, src) {
                    let id = format!("{file}::{n}");
                    let sig = ts_signature(child, src, file, &id, out);
                    emit_def(out, symbols, file, "method", n, child.start_position().row);
                    if !sig_is_empty(&sig) {
                        attach_signature(out, sig);
                    }
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

// ---------- Typed signature layer (TypeScript only) ----------
//
// Gated on TS-only `type_annotation` nodes. JS params/fields use different
// node kinds, so these produce empty signatures and no edges for JS, and the
// conditional `attach_signature` leaves JS nodes byte-identical.

fn sig_is_empty(sig: &Signature) -> bool {
    sig.params.is_empty() && sig.returns.is_none() && sig.fields.is_empty()
}

fn bare_type_text(type_annotation: TsNode, src: &str) -> Option<String> {
    let mut c = type_annotation.walk();
    type_annotation
        .children(&mut c)
        .find(|ch| ch.is_named())
        .and_then(|ch| ch.utf8_text(src.as_bytes()).ok())
        .map(|s| s.trim().to_string())
}

/// Recursively collect leaf type names (including primitives and stdlib
/// containers). A `generic_type` pushes its BASE name then recurses into each
/// named type argument: `Array<Pair<Foo,Bar>>` -> `[Array, Pair, Foo, Bar]`.
/// Container suppression happens at the emit site via `is_primitive_or_ignored`,
/// not here, so user generics like `Pair` keep their own edge.
fn extract_type_leaves(node: TsNode, src: &str, out: &mut Vec<String>) {
    match node.kind() {
        "type_identifier" | "predefined_type" => {
            if let Ok(s) = node.utf8_text(src.as_bytes()) {
                out.push(s.to_string());
            }
        }
        "nested_type_identifier" => {
            // Qualified `ns.Widget` -> trailing segment (last type_identifier).
            let mut c = node.walk();
            if let Some(last) = node
                .children(&mut c)
                .filter(|ch| ch.kind() == "type_identifier")
                .last()
                && let Ok(s) = last.utf8_text(src.as_bytes())
            {
                out.push(s.to_string());
            }
        }
        "generic_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                if ch.kind() == "type_arguments" {
                    let mut cc = ch.walk();
                    for arg in ch.children(&mut cc).filter(|a| a.is_named()) {
                        extract_type_leaves(arg, src, out);
                    }
                } else {
                    extract_type_leaves(ch, src, out);
                }
            }
        }
        "type_annotation" | "array_type" | "union_type" | "intersection_type" => {
            let mut c = node.walk();
            for ch in node.children(&mut c).filter(|ch| ch.is_named()) {
                extract_type_leaves(ch, src, out);
            }
        }
        _ => {}
    }
}

/// Collect type leaves, de-duped order-preservingly (`Pair<Foo,Foo>` -> one
/// `Foo`).
fn type_leaves(node: TsNode, src: &str) -> Vec<String> {
    let mut raw = Vec::new();
    extract_type_leaves(node, src, &mut raw);
    let mut out = Vec::new();
    for s in raw {
        if !out.contains(&s) {
            out.push(s);
        }
    }
    out
}

fn is_primitive_or_ignored(name: &str) -> bool {
    matches!(
        name,
        "number"
            | "string"
            | "boolean"
            | "null"
            | "undefined"
            | "void"
            | "never"
            | "any"
            | "unknown"
            | "object"
            | "symbol"
            | "bigint"
            // Stdlib generic containers.
            | "Array"
            | "ReadonlyArray"
            | "Promise"
            | "Map"
            | "Set"
            | "ReadonlyMap"
            | "ReadonlySet"
            | "Record"
            | "Partial"
            | "Readonly"
            | "Required"
            | "Pick"
            | "Omit"
    )
}

fn ts_signature(decl: TsNode, src: &str, file: &str, fn_id: &str, out: &mut Output) -> Signature {
    let mut sig = Signature::default();
    if let Some(params) = decl.child_by_field_name("parameters") {
        let mut cursor = params.walk();
        let mut index: u32 = 0;
        for p in params.children(&mut cursor) {
            if !matches!(p.kind(), "required_parameter" | "optional_parameter") {
                continue;
            }
            let name = p
                .child_by_field_name("pattern")
                .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                .map(|s| s.to_string())
                .unwrap_or_else(|| "_".to_string());
            let ty_anno = p.child_by_field_name("type");
            let ty_text = ty_anno.and_then(|t| bare_type_text(t, src));
            if let Some(t) = ty_anno {
                for leaf in type_leaves(t, src) {
                    if is_primitive_or_ignored(&leaf) {
                        continue;
                    }
                    out.edges.push(Edge {
                        source: fn_id.to_string(),
                        target: format!("extern::{leaf}"),
                        relation: "has_param".into(),
                        confidence: EXTRACTED,
                        attr: Some(EdgeAttr {
                            name: Some(name.clone()),
                            index: Some(index),
                        }),
                    });
                    out.nodes.push(Node {
                        id: format!("extern::{leaf}"),
                        label: leaf.clone(),
                        source_file: Some(file.to_string()),
                        source_location: Some(line_loc(p.start_position().row)),
                        kind: Some("type".into()),
                        signature: None,
                    });
                }
            }
            sig.params.push(ParamSig { name, ty: ty_text });
            index += 1;
        }
    }
    if let Some(ret) = decl.child_by_field_name("return_type") {
        sig.returns = bare_type_text(ret, src);
        for leaf in type_leaves(ret, src) {
            if is_primitive_or_ignored(&leaf) {
                continue;
            }
            out.edges.push(Edge {
                source: fn_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "returns".into(),
                confidence: EXTRACTED,
                attr: None,
            });
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(ret.start_position().row)),
                kind: Some("type".into()),
                signature: None,
            });
        }
    }
    sig
}

fn ts_class_or_interface_signature(
    decl: TsNode,
    src: &str,
    file: &str,
    type_id: &str,
    out: &mut Output,
) -> Signature {
    let mut sig = Signature::default();
    let Some(body) = decl.child_by_field_name("body") else {
        return sig;
    };
    let member_kind = match body.kind() {
        "class_body" => "public_field_definition",
        "interface_body" => "property_signature",
        _ => return sig,
    };
    let mut cursor = body.walk();
    for member in body.children(&mut cursor) {
        if member.kind() != member_kind {
            continue;
        }
        let Some(name) = member
            .child_by_field_name("name")
            .and_then(|n| n.utf8_text(src.as_bytes()).ok())
            .map(|s| s.to_string())
        else {
            continue;
        };
        let Some(ty_anno) = member.child_by_field_name("type") else {
            continue;
        };
        let ty_text = bare_type_text(ty_anno, src);
        for leaf in type_leaves(ty_anno, src) {
            if is_primitive_or_ignored(&leaf) {
                continue;
            }
            out.edges.push(Edge {
                source: type_id.to_string(),
                target: format!("extern::{leaf}"),
                relation: "has_field".into(),
                confidence: EXTRACTED,
                attr: Some(EdgeAttr {
                    name: Some(name.clone()),
                    index: None,
                }),
            });
            out.nodes.push(Node {
                id: format!("extern::{leaf}"),
                label: leaf.clone(),
                source_file: Some(file.to_string()),
                source_location: Some(line_loc(member.start_position().row)),
                kind: Some("type".into()),
                signature: None,
            });
        }
        sig.fields.push(FieldSig { name, ty: ty_text });
    }
    sig
}

#[cfg(test)]
mod tests {
    use super::*;
    use serde_json::Value;

    fn extract(path: &str, src: &str) -> Value {
        let bytes = extract_to_json(path, src).unwrap();
        serde_json::from_slice(&bytes).unwrap()
    }

    #[test]
    fn emits_typed_edges_and_signature_payload() {
        let v = extract(
            "s.ts",
            "class Widget { label: string; owner: Person; }\n\
             class Person { name: string; }\n\
             function build(count: number, pet: Widget): Widget { return pet; }\n",
        );
        let edges = v["edges"].as_array().unwrap();
        let hp = edges
            .iter()
            .find(|e| e["relation"] == "has_param")
            .expect("has_param edge");
        assert_eq!(hp["target"], "extern::Widget");
        assert_eq!(hp["attr"]["name"], "pet");
        assert_eq!(hp["attr"]["index"], 1);
        assert!(edges.iter().any(|e| e["relation"] == "returns"));
        assert!(
            edges
                .iter()
                .any(|e| e["relation"] == "has_field" && e["attr"]["name"] == "owner")
        );
        assert!(!edges.iter().any(|e| e["target"] == "extern::number"));

        let nodes = v["nodes"].as_array().unwrap();
        let build = nodes.iter().find(|n| n["label"] == "build").unwrap();
        let params = build["signature"]["params"].as_array().unwrap();
        assert_eq!(params.len(), 2);
        assert_eq!(params[0]["name"], "count");
        assert_eq!(params[0]["ty"], "number");
        assert_eq!(params[1]["name"], "pet");
        assert_eq!(params[1]["ty"], "Widget");
        assert_eq!(build["signature"]["returns"], "Widget");
        assert!(
            nodes
                .iter()
                .any(|n| n["kind"] == "type" && n["id"] == "extern::Widget")
        );
    }

    #[test]
    fn js_emits_no_typed_edges() {
        let v = extract("s.js", "function build(count, pet) { return pet; }\n");
        let edges = v["edges"].as_array().unwrap();
        assert!(!edges.iter().any(|e| matches!(
            e["relation"].as_str(),
            Some("has_param" | "has_field" | "returns")
        )));
        let nodes = v["nodes"].as_array().unwrap();
        let build = nodes.iter().find(|n| n["label"] == "build").unwrap();
        assert!(build.get("signature").is_none() || build["signature"].is_null());
    }
}
