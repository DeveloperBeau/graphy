//! Lang coverage: bash. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//!
//! Note: Bash has no classes or inheritance. No class/inherits/implements assertions.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "bash";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/bash"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("service.sh").exists());
}

#[test]
fn types_emits_keyword_form_function() {
    let out = extract_file(&fp("types.sh"));
    assert_extract_has(&out, "new_state", "function");
}

#[test]
fn helpers_emits_both_function_forms() {
    let out = extract_file(&fp("helpers.sh"));
    // POSIX form: format_name() { ... }
    assert_extract_has(&out, "format_name", "function");
    // keyword form: function unrelated_helper { ... }
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_emits_source_and_dot_imports() {
    let out = extract_file(&fp("service.sh"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "source helpers.sh import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("types")),
        ". types.sh dot-source import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_emits_functions() {
    let out = extract_file(&fp("service.sh"));
    assert_extract_has(&out, "run_service", "function");
    assert_extract_has(&out, "describe_service", "function");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("empty.sh"));
    assert!(out.nodes.is_empty(), "empty.sh produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.sh produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.sh");
    std::fs::write(&p, "function (((( {\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_sh_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.sh");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_function_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
    assert_node(&g, "run_service", "function");
}

#[test]
fn pipeline_emits_source_imports() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_imports = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_imports, "no imports edges in pipeline output");
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
fn pipeline_does_not_emit_calls_to_echo() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
    // echo is an external command; must not produce a local calls edge.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let echo_calls = g
        .graph
        .edge_references()
        .filter(|e| {
            e.weight().relation == "calls"
                && g.graph[e.target()].label.contains("echo")
        })
        .count();
    assert_eq!(echo_calls, 0, "unexpected call edge to echo");
}
