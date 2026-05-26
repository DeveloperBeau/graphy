//! Lang coverage: toml. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-toml.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "toml";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/toml"),
        "fixture_dir(toml) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("Cargo.toml").exists(), "Cargo.toml missing");
}

#[test]
fn cargo_toml_emits_package_table_node() {
    let out = extract_file(&fp("Cargo.toml"));
    // [package] -> table node
    assert_extract_has(&out, "package", "table");
}

#[test]
fn cargo_toml_emits_nested_section_node() {
    let out = extract_file(&fp("Cargo.toml"));
    // [package.metadata] -> table node with label "package.metadata"
    assert_extract_has(&out, "package.metadata", "table");
}

#[test]
fn cargo_toml_emits_dependencies_table() {
    let out = extract_file(&fp("Cargo.toml"));
    assert_extract_has(&out, "dependencies", "table");
    assert_extract_has(&out, "dev-dependencies", "table");
}

#[test]
fn cargo_toml_emits_array_of_tables_nodes() {
    let out = extract_file(&fp("Cargo.toml"));
    // [[bin]] appears twice -> two table_array_element nodes both labeled "bin"
    let bin_nodes: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.label == "bin" && n.kind.as_deref() == Some("table_array_element"))
        .collect();
    assert!(
        bin_nodes.len() >= 2,
        "expected at least 2 [[bin]] table_array_element nodes; got {}",
        bin_nodes.len()
    );
}

#[test]
fn cargo_toml_emits_no_edges() {
    // TOML has no cross-file references; no edges expected.
    let out = extract_file(&fp("Cargo.toml"));
    assert!(
        out.edges.is_empty(),
        "expected no edges from Cargo.toml; edges = {:#?}",
        out.edges
    );
}

#[test]
fn config_toml_emits_section_nodes() {
    let out = extract_file(&fp("config.toml"));
    // [server], [database], [logging], [features]
    assert_extract_has(&out, "server", "table");
    assert_extract_has(&out, "database", "table");
    assert_extract_has(&out, "logging", "table");
    assert_extract_has(&out, "features", "table");
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.toml"));
    assert!(out.nodes.is_empty(), "empty.toml produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.toml produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.toml");
    std::fs::write(&p, "[unclosed\nkey = {").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_toml_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.toml");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// TOML (.toml) has been added to CODE_EXTENSIONS so the pipeline picks it up
// by default. No cross-file edges expected.

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_emits_cargo_toml_section_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "package", "table");
    assert_node(&g, "package.metadata", "table");
    assert_node(&g, "dependencies", "table");
}

#[test]
fn pipeline_emits_config_toml_section_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // These sections are unique to config.toml
    assert_node(&g, "server", "table");
    assert_node(&g, "database", "table");
    assert_node(&g, "logging", "table");
    assert_node(&g, "features", "table");
}

#[test]
fn pipeline_emits_array_of_tables_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bin_nodes: Vec<_> = g
        .graph
        .node_weights()
        .filter(|n| n.label == "bin" && n.kind.as_deref() == Some("table_array_element"))
        .collect();
    assert!(
        !bin_nodes.is_empty(),
        "expected table_array_element nodes for [[bin]] in pipeline output"
    );
}

#[test]
fn pipeline_emits_no_edges() {
    // TOML has no cross-file references; pipeline should produce zero edges.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let edge_count = g.graph.edge_references().count();
    assert_eq!(
        edge_count, 0,
        "expected 0 edges for TOML-only fixture; got {edge_count}"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // Cargo.toml: 6 nodes (package, package.metadata, dependencies, dev-dependencies, bin x2)
    // config.toml: 4 nodes (server, database, logging, features)
    // Total: 10 nodes (dedup merges nothing as labels are unique)
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
