//! Lang coverage: pascal. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "pascal";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/pascal"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.pas").exists());
}

#[test]
fn types_emits_type_nodes() {
    let out = extract_file(&fp("src/types.pas"));
    let type_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("type"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        type_labels.iter().any(|l| *l == "TState"),
        "TState type not found; got {type_labels:?}"
    );
    assert!(
        type_labels.iter().any(|l| *l == "TService"),
        "TService type not found; got {type_labels:?}"
    );
}

#[test]
fn helpers_emits_function_nodes() {
    let out = extract_file(&fp("src/helpers.pas"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.iter().any(|l| *l == "FormatName"),
        "FormatName not found; got {fn_labels:?}"
    );
    assert!(
        fn_labels.iter().any(|l| *l == "UnrelatedHelper"),
        "UnrelatedHelper not found; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_type_node_for_class() {
    let out = extract_file(&fp("src/service.pas"));
    assert_extract_has(&out, "TServiceRunner", "type");
}

#[test]
fn service_emits_function_nodes() {
    let out = extract_file(&fp("src/service.pas"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        !fn_labels.is_empty(),
        "no function nodes from service.pas; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_uses_import() {
    let out = extract_file(&fp("src/service.pas"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        !import_labels.is_empty(),
        "no import nodes from service.pas; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers") || l.contains("Types")),
        "Helpers/Types import not found; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.pas"));
    assert!(out.nodes.is_empty(), "empty.pas produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.pas produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.pas");
    std::fs::write(&p, "unit Broken;\ninterface\nprocedure Foo(;\nend.\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.pas");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_resolves_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has = g
        .graph
        .node_weights()
        .any(|n| n.label == "FormatName" && n.kind.as_deref() == Some("function"));
    assert!(has, "FormatName function node missing from pipeline graph");
}

#[test]
fn pipeline_emits_import_edges() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no import edges in pipeline output");
}

#[test]
fn pipeline_preserves_type_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "TState", "type");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 5;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
