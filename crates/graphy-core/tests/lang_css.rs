//! Lang coverage: css. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-css.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "css";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/css"),
        "fixture_dir(css) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("main.css").exists(), "main.css missing");
}

#[test]
fn main_emits_element_selector() {
    let out = extract_file(&fp("main.css"));
    assert_extract_has(&out, "body", "selector");
}

#[test]
fn main_emits_id_selector() {
    let out = extract_file(&fp("main.css"));
    assert_extract_has(&out, "#main", "selector");
}

#[test]
fn main_emits_class_selector() {
    let out = extract_file(&fp("main.css"));
    assert_extract_has(&out, ".card", "selector");
}

#[test]
fn main_emits_import_edge_for_theme() {
    let out = extract_file(&fp("main.css"));
    let has_theme = out
        .edges
        .iter()
        .any(|e| e.relation == "imports" && e.target == "css::theme.css");
    assert!(
        has_theme,
        "expected imports edge to css::theme.css; edges = {:#?}",
        out.edges
    );
}

#[test]
fn main_emits_import_edge_for_components() {
    let out = extract_file(&fp("main.css"));
    let has_components = out
        .edges
        .iter()
        .any(|e| e.relation == "imports" && e.target == "css::components.css");
    assert!(
        has_components,
        "expected imports edge to css::components.css; edges = {:#?}",
        out.edges
    );
}

#[test]
fn theme_emits_root_and_body_selectors() {
    let out = extract_file(&fp("theme.css"));
    assert_extract_has(&out, ":root", "selector");
    assert_extract_has(&out, "body", "selector");
}

#[test]
fn components_emits_btn_selector() {
    let out = extract_file(&fp("components.css"));
    assert_extract_has(&out, ".btn", "selector");
    assert_extract_has(&out, ".btn-primary", "selector");
}

#[test]
fn components_emits_nav_id_selector() {
    let out = extract_file(&fp("components.css"));
    assert_extract_has(&out, "#nav", "selector");
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.css"));
    assert!(
        out.nodes.is_empty(),
        "empty.css produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.css produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.css");
    std::fs::write(&p, ".unclosed { color: red").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_css_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.css");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// CSS (.css) is in CODE_EXTENSIONS so the pipeline picks it up by default.

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_selector_nodes_from_all_css_files() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // `body` appears in both main.css and theme.css; dedup marks it "selector?ambiguous".
    // Use a looser check: at least one node with label "body" exists (any kind).
    let has_body = g.graph.node_weights().any(|n| n.label == "body");
    assert!(has_body, "no node with label 'body' in pipeline output");
    // These selectors are unique across the fixture
    assert_node(&g, "#main", "selector");
    assert_node(&g, ".card", "selector");
    assert_node(&g, ".btn", "selector");
    assert_node(&g, ":root", "selector");
}

#[test]
fn pipeline_emits_import_edges() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let import_count = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "imports")
        .count();
    // main.css imports theme.css and components.css = 2 import edges minimum
    assert!(
        import_count >= 2,
        "expected at least 2 imports edges; got {import_count}"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // main.css: 6 selectors, theme.css: 3, components.css: 5 = 14 minimum
    const FLOOR: usize = 10;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_main_imports_theme_css() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // @import "theme.css" produces imports edge targeting css::theme.css node
    let has_theme_import = g.graph.edge_references().any(|e| {
        e.weight().relation == "imports" && g.graph[e.target()].label.contains("theme.css")
    });
    assert!(
        has_theme_import,
        "expected imports edge targeting theme.css in pipeline graph"
    );
}
