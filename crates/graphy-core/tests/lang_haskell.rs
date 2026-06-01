//! Lang coverage: haskell. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "haskell";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/haskell"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/Service.hs").exists());
}

#[test]
fn types_emits_data_nodes() {
    let out = extract_file(&fp("src/Types.hs"));
    // data State = Idle | Running | Done  -> data_type
    assert_extract_has(&out, "State", "data_type");
    // data Service = Service {...}        -> data_type
    assert_extract_has(&out, "Service", "data_type");
}

#[test]
fn types_emits_newtype_node() {
    let out = extract_file(&fp("src/Types.hs"));
    assert_extract_has(&out, "ServiceName", "newtype");
}

#[test]
fn types_emits_type_synonym_nodes() {
    let out = extract_file(&fp("src/Types.hs"));
    assert_extract_has(&out, "Id", "type_synomym");
    assert_extract_has(&out, "Name", "type_synomym");
}

#[test]
fn types_emits_class_node() {
    let out = extract_file(&fp("src/Types.hs"));
    assert_extract_has(&out, "Greet", "class");
}

#[test]
fn types_emits_instance_node() {
    let out = extract_file(&fp("src/Types.hs"));
    assert_extract_has(&out, "Greet", "instance");
}

#[test]
fn helpers_emits_function_nodes() {
    let out = extract_file(&fp("src/Helpers.hs"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.contains(&"formatName"),
        "formatName not found; got {fn_labels:?}"
    );
    assert!(
        fn_labels.contains(&"unrelatedHelper"),
        "unrelatedHelper not found; got {fn_labels:?}"
    );
}

#[test]
fn helpers_emits_import_nodes() {
    let out = extract_file(&fp("src/Helpers.hs"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Data.Char")),
        "Data.Char import not found; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Data.Map")),
        "Data.Map import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_import_for_types() {
    let out = extract_file(&fp("src/Service.hs"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Types")),
        "Types import not found; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "Helpers import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_function_nodes() {
    let out = extract_file(&fp("src/Service.hs"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels
            .iter()
            .any(|l| *l == "runService" || *l == "makeService"),
        "runService/makeService not found in functions; got {fn_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.hs"));
    assert!(
        out.nodes.is_empty(),
        "Empty.hs produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "Empty.hs produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.hs");
    std::fs::write(&p, "module Broken where\nfoo :: Int ->\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.hs");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // formatName should exist in the graph (from Helpers.hs)
    let has_fn = g
        .graph
        .node_weights()
        .any(|n| n.label == "formatName" && n.kind.as_deref() == Some("function"));
    assert!(
        has_fn,
        "formatName function node missing from pipeline graph"
    );
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
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_preserves_data_type_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "State", "data_type");
}
