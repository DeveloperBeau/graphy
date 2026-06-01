//! Java extractor.

use std::collections::HashMap;
use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use super::common::{emit_call, emit_def, emit_import, name_of};
use crate::schema::{Confidence, Edge, ExtractionOutput};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_java::LANGUAGE.into())
        .context("load tree-sitter-java")?;
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
            "method_declaration" | "constructor_declaration" => {
                if let Some(n) = name_of(child, src) {
                    emit_def(out, symbols, file, "method", n, child);
                }
            }
            "class_declaration"
            | "interface_declaration"
            | "enum_declaration"
            | "record_declaration" => {
                if let Some(n) = name_of(child, src) {
                    let node_kind = child.kind().trim_end_matches("_declaration");
                    let class_id = format!("{file}::{n}");
                    emit_def(out, symbols, file, node_kind, n, child);
                    // Emit inherits/implements edges.
                    emit_java_hierarchy(child, src, &class_id, out);
                }
            }
            "import_declaration" => {
                let text = child.utf8_text(src.as_bytes()).expect("utf8 source");
                // Java wildcard `import java.util.*;` lands here intact — `*` survives
                // trim() so dedup::is_glob can later identify it.
                let target = text
                    .trim_start_matches("import")
                    .trim_end_matches(';')
                    .trim();
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
        if matches!(
            child.kind(),
            "method_declaration" | "constructor_declaration"
        ) && let Some(name) = name_of(child, src)
        {
            let caller_id = format!("{file}::{name}");
            collect_calls(child, src, &caller_id, out, symbols);
        }
        walk_calls(child, src, file, out, symbols);
    }
}

/// Walk the direct type-reference children of superclass / interfaces clauses
/// and emit `inherits` (extends) and `implements` edges.
fn emit_java_hierarchy(node: TsNode, src: &str, class_id: &str, out: &mut ExtractionOutput) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        let relation = match child.kind() {
            "superclass" => "inherits",
            "super_interfaces" | "interfaces" => "implements",
            _ => continue,
        };
        // The direct children of superclass/super_interfaces include a
        // type_list or a single type node. Walk their named children to
        // find `type_identifier` leaves.
        collect_type_identifiers(child, src, class_id, relation, out);
    }
}

fn collect_type_identifiers(
    node: TsNode,
    src: &str,
    class_id: &str,
    relation: &str,
    out: &mut ExtractionOutput,
) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if child.kind() == "type_identifier"
            && let Ok(name) = child.utf8_text(src.as_bytes())
        {
            let name = name.trim();
            if !name.is_empty() {
                out.edges.push(Edge {
                    source: class_id.to_string(),
                    target: format!("extern::{name}"),
                    relation: relation.to_string(),
                    confidence: Confidence::Extracted,
                });
            }
        }
        collect_type_identifiers(child, src, class_id, relation, out);
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
        if child.kind() == "method_invocation"
            && let Some(fn_node) = child.child_by_field_name("name")
        {
            let text = fn_node.utf8_text(src.as_bytes()).expect("utf8 source");
            emit_call(out, symbols, caller_id, text);
        }
        collect_calls(child, src, caller_id, out, symbols);
    }
}
