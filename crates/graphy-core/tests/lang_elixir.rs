//! Lang coverage: elixir. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "elixir";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/elixir"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("lib/service.ex").exists());
}

#[test]
fn types_emits_module_and_functions() {
    let out = extract_file(&fp("lib/types.ex"));
    assert_extract_has(&out, "Types", "module");
    assert_extract_has(&out, "max_retries", "function");
    assert_extract_has(&out, "internal_name", "function");
    assert_extract_has(&out, "service_name", "function");
}

#[test]
fn types_emits_call_edge_for_defp_call() {
    let out = extract_file(&fp("lib/types.ex"));
    // service_name calls internal_name; the extractor emits a calls edge
    let has_calls = out.edges.iter().any(|e| e.relation == "calls");
    assert!(has_calls, "expected calls edge in types.ex; edges = {:#?}", out.edges);
}

#[test]
fn helpers_emits_module_and_functions() {
    let out = extract_file(&fp("lib/helpers.ex"));
    assert_extract_has(&out, "Helpers", "module");
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_emits_module_and_functions() {
    let out = extract_file(&fp("lib/service.ex"));
    assert_extract_has(&out, "Service", "module");
    assert_extract_has(&out, "run", "function");
    assert_extract_has(&out, "describe", "function");
    assert_extract_has(&out, "private_run", "function");
}

#[test]
fn service_emits_alias_import_require() {
    let out = extract_file(&fp("lib/service.ex"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "alias Helpers import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("String")),
        "import String not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Logger")),
        "require Logger not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("lib/empty.ex"));
    assert!(out.nodes.is_empty(), "empty.ex produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.ex produced edges: {:#?}", out.edges);
}

// ---------- Deferred follow-up: defstruct node ----------

#[test]
fn types_emits_struct_node() {
    let out = extract_file(&fp("lib/types.ex"));
    // defstruct [:name, :active] inside Types module should emit a struct node
    // labeled with the enclosing module name ("Types")
    let has_struct = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("struct") && n.label == "Types");
    assert!(
        has_struct,
        "expected struct node labeled Types; nodes = {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.ex");
    std::fs::write(&p, "defmodule (((( do\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_ex_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.ex");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_module_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Service", "module");
    assert_node(&g, "Helpers", "module");
    assert_node(&g, "Types", "module");
}

#[test]
fn pipeline_emits_function_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
    assert_node(&g, "run", "function");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_imports = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_imports, "no imports edges in pipeline output");
}

#[test]
fn pipeline_emits_call_edges() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_calls = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "calls");
    assert!(has_calls, "no calls edges in pipeline output");
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
