//! Lang coverage: html. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-html.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "html";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/html"),
        "fixture_dir(html) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("index.html").exists(), "index.html missing");
}

#[test]
fn index_emits_id_bearing_element_nodes() {
    let out = extract_file(&fp("index.html"));
    // <div id="main">, <nav id="nav">, <section id="content">, <div id="footer">
    assert_extract_has(&out, "div#main", "div");
    assert_extract_has(&out, "nav#nav", "nav");
    assert_extract_has(&out, "section#content", "section");
    assert_extract_has(&out, "div#footer", "div");
}

#[test]
fn index_emits_link_stylesheet_reference() {
    let out = extract_file(&fp("index.html"));
    // <link rel="stylesheet" href="styles.css"> -> references edge
    let has_styles = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target == "link::styles.css");
    assert!(
        has_styles,
        "expected references edge to link::styles.css; edges = {:#?}",
        out.edges
    );
}

#[test]
fn index_emits_script_src_reference() {
    let out = extract_file(&fp("index.html"));
    // <script src="app.js"> -> references edge
    let has_script = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target == "link::app.js");
    assert!(
        has_script,
        "expected references edge to link::app.js; edges = {:#?}",
        out.edges
    );
}

#[test]
fn index_emits_anchor_href_reference() {
    let out = extract_file(&fp("index.html"));
    // <a href="about.html"> -> references edge
    let has_about = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target.contains("about.html"));
    assert!(
        has_about,
        "expected references edge to about.html; edges = {:#?}",
        out.edges
    );
}

#[test]
fn index_emits_img_src_reference() {
    let out = extract_file(&fp("index.html"));
    // <img src="logo.png"> -> references edge
    let has_img = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target == "link::logo.png");
    assert!(
        has_img,
        "expected references edge to link::logo.png; edges = {:#?}",
        out.edges
    );
}

#[test]
fn about_emits_id_bearing_elements() {
    let out = extract_file(&fp("about.html"));
    assert_extract_has(&out, "div#section", "div");
    assert_extract_has(&out, "div#contact", "div");
}

#[test]
fn about_emits_back_reference_to_index() {
    let out = extract_file(&fp("about.html"));
    let has_index = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target.contains("index.html"));
    assert!(
        has_index,
        "expected references edge back to index.html; edges = {:#?}",
        out.edges
    );
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.html"));
    assert!(
        out.nodes.is_empty(),
        "empty.html produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.html produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.html");
    std::fs::write(&p, "<div id='unclosed").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_html_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.html");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// HTML (.html/.htm) is in CODE_EXTENSIONS so the pipeline picks it up with
// include_docs=false (the default). The fixture dir also contains styles.css
// which is processed as CSS; both are captured in the same pipeline run.

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_id_nodes_from_all_html_files() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // Both index.html and about.html have id-bearing elements
    assert_node(&g, "div#main", "div");
    assert_node(&g, "section#content", "section");
    assert_node(&g, "div#section", "div");
}

#[test]
fn pipeline_emits_references_edges() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let ref_count = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "references")
        .count();
    // index.html: 5 refs, about.html: 2 refs = 7 total
    assert!(
        ref_count >= 5,
        "expected at least 5 references edges; got {ref_count}"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // index.html: 4 id nodes, about.html: 2 id nodes, + link:: target nodes, + CSS selector nodes
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_index_references_about_via_href() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // <a href="about.html"> in index.html -> references edge with target label containing "about.html"
    let has_about_ref = g.graph.edge_references().any(|e| {
        e.weight().relation == "references" && g.graph[e.target()].label.contains("about.html")
    });
    assert!(
        has_about_ref,
        "expected references edge targeting about.html in pipeline graph"
    );
}

// ---------- Typed signature layer: none (structural format) ----------

#[test]
fn emits_no_typed_signature_layer() {
    let out = extract_file(&fp("about.html"));
    assert!(
        out.nodes.iter().all(|n| n.signature.is_none()),
        "no signatures expected"
    );
    assert!(
        !out.edges
            .iter()
            .any(|e| matches!(e.relation.as_str(), "has_param" | "returns" | "has_field")),
        "no typed edges expected"
    );
    assert!(
        !out.nodes.iter().any(|n| n.kind.as_deref() == Some("type")),
        "no type nodes expected"
    );
}
