//! Lang coverage: erlang. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Note: Erlang is a functional language without inheritance/class system.
//! `inherits` and `implements` assertions are N/A and intentionally absent.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "erlang";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/erlang"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.erl").exists());
}

#[test]
fn service_emits_module_node() {
    let out = extract_file(&fp("src/service.erl"));
    assert_extract_has(&out, "service", "module");
}

#[test]
fn service_emits_function_nodes() {
    let out = extract_file(&fp("src/service.erl"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.iter().any(|l| *l == "run" || *l == "make"),
        "run/make functions not found; got {fn_labels:?}"
    );
}

#[test]
fn helpers_emits_module_node() {
    let out = extract_file(&fp("src/helpers.erl"));
    assert_extract_has(&out, "helpers", "module");
}

#[test]
fn helpers_emits_function_nodes() {
    let out = extract_file(&fp("src/helpers.erl"));
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
    assert!(
        fn_labels.contains(&"unrelated_helper"),
        "unrelated_helper not found; got {fn_labels:?}"
    );
}

#[test]
fn types_emits_module_node() {
    let out = extract_file(&fp("src/types.erl"));
    assert_extract_has(&out, "types", "module");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.erl"));
    assert!(
        out.nodes.is_empty(),
        "empty.erl produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.erl produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.erl");
    std::fs::write(&p, "-module(broken).\nfoo(X -> X.\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.erl");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Deferred closure: -import directive ----------

#[test]
fn service_emits_import_node_for_import_directive() {
    let out = extract_file(&fp("src/service.erl"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "helpers import node from -import directive not found; import nodes = {import_labels:?}"
    );
}

#[test]
fn service_emits_imports_edge_for_import_directive() {
    let out = extract_file(&fp("src/service.erl"));
    let has_edge = out.edges.iter().any(|e| e.relation == "imports");
    assert!(
        has_edge,
        "no imports edge emitted from service.erl; edges = {:#?}",
        out.edges
    );
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_helpers_module() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "helpers", "module");
}

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
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 5;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_emits_no_inherits_or_implements_edges() {
    // Erlang has no class/inheritance system; these edge kinds must be absent.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad: Vec<_> = g
        .graph
        .edge_references()
        .filter(|e| matches!(e.weight().relation.as_str(), "inherits" | "implements"))
        .collect();
    assert!(
        bad.is_empty(),
        "unexpected inherits/implements edges: {bad:#?}"
    );
}
