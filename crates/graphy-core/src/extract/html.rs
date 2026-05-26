//! HTML extractor — element ids become nodes, `<script src>`/`<link href>`
//! become reference edges.

use std::path::Path;

use anyhow::{Context, Result};
use tree_sitter::{Node as TsNode, Parser};

use crate::schema::{Confidence, Edge, ExtractionOutput, Node};

pub fn extract(path: &Path) -> Result<ExtractionOutput> {
    let src = std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
    let mut parser = Parser::new();
    parser
        .set_language(&tree_sitter_html::LANGUAGE.into())
        .context("load tree-sitter-html")?;
    let tree = parser
        .parse(&src, None)
        .expect("tree-sitter parse() returns Some when language is set");
    let file = path.to_string_lossy().into_owned();
    let mut out = ExtractionOutput::default();
    walk(tree.root_node(), &src, &file, &mut out);
    Ok(out)
}

fn attribute_value<'src>(attr: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = attr.walk();
    attr.named_children(&mut cursor)
        .find_map(|c| match c.kind() {
            "quoted_attribute_value" => c
                .named_child(0)
                .and_then(|inner| inner.utf8_text(src.as_bytes()).ok())
                .or(Some("")),
            "attribute_value" => c.utf8_text(src.as_bytes()).ok(),
            _ => None,
        })
}

fn attribute_name<'src>(attr: TsNode, src: &'src str) -> Option<&'src str> {
    let mut cursor = attr.walk();
    attr.named_children(&mut cursor)
        .find(|c| c.kind() == "attribute_name")
        .and_then(|c| c.utf8_text(src.as_bytes()).ok())
}

fn walk(node: TsNode, src: &str, file: &str, out: &mut ExtractionOutput) {
    let mut cursor = node.walk();
    for child in node.children(&mut cursor) {
        if matches!(child.kind(), "element" | "script_element" | "style_element") {
            let mut sub = child.walk();
            for c in child.children(&mut sub) {
                if matches!(c.kind(), "start_tag" | "self_closing_tag") {
                    let tag_name = c
                        .named_child(0)
                        .and_then(|n| n.utf8_text(src.as_bytes()).ok())
                        .unwrap_or("element");
                    let mut id_value: Option<String> = None;
                    let mut href: Option<String> = None;
                    let mut src_attr: Option<String> = None;
                    let mut acur = c.walk();
                    for a in c.children(&mut acur) {
                        if a.kind() == "attribute" {
                            let name = attribute_name(a, src).unwrap_or("");
                            let value = attribute_value(a, src).unwrap_or("");
                            match name {
                                "id" => id_value = Some(value.into()),
                                "href" => href = Some(value.into()),
                                "src" => src_attr = Some(value.into()),
                                _ => {}
                            }
                        }
                    }
                    if let Some(id) = id_value {
                        out.nodes.push(Node {
                            id: format!("{file}#{id}"),
                            label: format!("{tag_name}#{id}"),
                            source_file: Some(file.to_string()),
                            source_location: Some(format!("L{}", c.start_position().row + 1)),
                            kind: Some(tag_name.to_string()),
                        });
                    }
                    if let Some(target) = href.or(src_attr) {
                        out.edges.push(Edge {
                            source: file.to_string(),
                            target: format!("link::{target}"),
                            relation: "references".into(),
                            confidence: Confidence::Extracted,
                        });
                    }
                }
            }
        }
        walk(child, src, file, out);
    }
}
