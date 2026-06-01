//! Lang coverage: r. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//!
//! Note: R has no built-in class/inheritance syntax. No class/inherits assertions.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "r";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/r"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("service.R").exists());
}

#[test]
fn types_emits_function_assignment() {
    let out = extract_file(&fp("types.R"));
    assert_extract_has(&out, "new_state", "function");
}

#[test]
fn helpers_emits_two_functions() {
    let out = extract_file(&fp("helpers.R"));
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn helpers_emits_library_import() {
    let out = extract_file(&fp("helpers.R"));
    let has_import = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("methods"));
    assert!(
        has_import,
        "expected library(methods) import; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_functions() {
    let out = extract_file(&fp("service.R"));
    assert_extract_has(&out, "run_service", "function");
    assert_extract_has(&out, "describe_service", "function");
}

#[test]
fn service_emits_library_require_source_imports() {
    let out = extract_file(&fp("service.R"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("methods")),
        "library(methods) import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("utils")),
        "require(utils) import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "source(helpers.R) import not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("empty.R"));
    assert!(
        out.nodes.is_empty(),
        "empty.R produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.R produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.R");
    std::fs::write(&p, "f <- function(((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_r_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.R");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

#[test]
fn pipeline_emits_function_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
    assert_node(&g, "run_service", "function");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    use petgraph::visit::IntoEdgeReferences;
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
fn pipeline_equals_form_function_present() {
    // unrelated_helper uses `=` assignment form; verify it's extracted
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "unrelated_helper", "function");
}
