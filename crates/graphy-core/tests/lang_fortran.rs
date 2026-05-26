//! Lang coverage: fortran. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Note: Fortran is a procedural language without inheritance/class system
//! (beyond derived types). `inherits` and `implements` assertions are N/A.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "fortran";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/fortran"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.f90").exists());
}

#[test]
fn helpers_emits_module_node() {
    let out = extract_file(&fp("src/helpers.f90"));
    assert_extract_has(&out, "helpers", "module");
}

#[test]
fn helpers_emits_subroutine_and_function() {
    let out = extract_file(&fp("src/helpers.f90"));
    let node_labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(
        node_labels.iter().any(|l| *l == "format_name"),
        "format_name not found; got {node_labels:?}"
    );
    assert!(
        node_labels.iter().any(|l| *l == "unrelated_helper"),
        "unrelated_helper not found; got {node_labels:?}"
    );
}

#[test]
fn types_emits_module_node() {
    let out = extract_file(&fp("src/types.f90"));
    assert_extract_has(&out, "types", "module");
}

#[test]
fn service_emits_module_node() {
    let out = extract_file(&fp("src/service.f90"));
    assert_extract_has(&out, "service", "module");
}

#[test]
fn service_emits_use_imports() {
    let out = extract_file(&fp("src/service.f90"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("types")),
        "types use-import not found; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "helpers use-import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_subroutine_and_function() {
    let out = extract_file(&fp("src/service.f90"));
    let node_labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(
        node_labels.iter().any(|l| *l == "run_service" || *l == "make_state"),
        "run_service/make_state not found; got {node_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.f90"));
    assert!(out.nodes.is_empty(), "empty.f90 produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.f90 produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.f90");
    std::fs::write(&p, "module broken\n  subroutine foo(\nend module broken\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.f90");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_resolves_helpers_module() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "helpers", "module");
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
    const FLOOR: usize = 4;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_emits_no_inherits_or_implements_edges() {
    // Fortran does not have an inheritance/implements relationship in extractor.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad: Vec<_> = g
        .graph
        .edge_references()
        .filter(|e| matches!(e.weight().relation.as_str(), "inherits" | "implements"))
        .collect();
    assert!(bad.is_empty(), "unexpected inherits/implements edges: {bad:#?}");
}
