//! Lang coverage: groovy. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "groovy";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/groovy"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("src/Types.groovy").exists());
}

#[test]
fn types_emits_interface_and_enum() {
    let out = extract_file(&fp("src/Types.groovy"));
    assert_extract_has(&out, "Greet", "interface");
    assert_extract_has(&out, "State", "enum");
}

#[test]
fn helpers_emits_class_and_methods() {
    let out = extract_file(&fp("src/Helpers.groovy"));
    assert_extract_has(&out, "Helpers", "class");
    assert_extract_has(&out, "formatName", "method");
    assert_extract_has(&out, "unrelatedHelper", "method");
}

#[test]
fn helpers_emits_import() {
    let out = extract_file(&fp("src/Helpers.groovy"));
    let has_import = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("java.util.List"));
    assert!(
        has_import,
        "expected import for java.util.List; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/Service.groovy"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "run", "method");
    assert_extract_has(&out, "describe", "method");
}

#[test]
fn service_emits_imports() {
    let out = extract_file(&fp("src/Service.groovy"));
    let has_import = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("java.util"));
    assert!(
        has_import,
        "expected java.util import; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.groovy"));
    assert!(out.nodes.is_empty(), "empty.groovy produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.groovy produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.groovy");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_groovy_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.groovy");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_class_and_method_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Helpers", "class");
    assert_node(&g, "Service", "class");
}

#[test]
fn pipeline_emits_interface_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Greet", "interface");
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
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 6;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
