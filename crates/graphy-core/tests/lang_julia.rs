//! Lang coverage: julia. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "julia";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/julia"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/Service.jl").exists());
}

#[test]
fn types_emits_abstract_type() {
    let out = extract_file(&fp("src/Types.jl"));
    assert_extract_has(&out, "State", "abstract");
}

#[test]
fn types_emits_struct_nodes() {
    let out = extract_file(&fp("src/Types.jl"));
    assert_extract_has(&out, "IdleState", "struct");
    assert_extract_has(&out, "RunningState", "struct");
    assert_extract_has(&out, "Service", "struct");
}

#[test]
fn helpers_emits_function_nodes() {
    let out = extract_file(&fp("src/Helpers.jl"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.contains(&"format_name"),
        "format_name not found; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_import_for_linear_algebra() {
    let out = extract_file(&fp("src/Service.jl"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("LinearAlgebra")),
        "LinearAlgebra import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_import_for_helpers() {
    let out = extract_file(&fp("src/Service.jl"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "Helpers import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_struct_and_functions() {
    let out = extract_file(&fp("src/Service.jl"));
    assert_extract_has(&out, "ServiceConfig", "struct");
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels
            .iter()
            .any(|l| *l == "make_service" || *l == "run_service"),
        "make_service/run_service not found; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_calls_edges() {
    let out = extract_file(&fp("src/Service.jl"));
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(
        !calls.is_empty(),
        "no calls edges from Service.jl; edges = {:#?}",
        out.edges
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.jl"));
    assert!(
        out.nodes.is_empty(),
        "Empty.jl produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "Empty.jl produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.jl");
    std::fs::write(&p, "function foo(\n  x =\nend\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.jl");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has = g
        .graph
        .node_weights()
        .any(|n| n.label == "format_name" && n.kind.as_deref() == Some("function"));
    assert!(has, "format_name function node missing from pipeline graph");
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
fn pipeline_preserves_abstract_type() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "State", "abstract");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 6;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
