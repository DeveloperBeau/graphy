//! Lang coverage: json. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-json.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "json";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/json"),
        "fixture_dir(json) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("config.json").exists(), "config.json missing");
}

#[test]
fn config_emits_top_level_key_nodes() {
    let out = extract_file(&fp("config.json"));
    // Top-level keys: name, version, description, main, scripts, dependencies, schema
    assert_extract_has(&out, "name", "json_key");
    assert_extract_has(&out, "version", "json_key");
    assert_extract_has(&out, "description", "json_key");
}

#[test]
fn config_emits_nested_key_nodes() {
    let out = extract_file(&fp("config.json"));
    // Nested keys inside scripts: test, build
    assert_extract_has(&out, "test", "json_key");
    assert_extract_has(&out, "build", "json_key");
}

#[test]
fn config_emits_ref_edge_for_schema() {
    let out = extract_file(&fp("config.json"));
    // "schema": { "$ref": "schema.json#/definitions/Config" }
    // -> $ref key emits references edge with target ref::schema.json#/definitions/Config
    let has_ref = out
        .edges
        .iter()
        .any(|e| e.relation == "references" && e.target == "ref::schema.json#/definitions/Config");
    assert!(
        has_ref,
        "expected references edge to ref::schema.json#/definitions/Config; edges = {:#?}",
        out.edges
    );
}

#[test]
fn schema_emits_json_schema_key_nodes() {
    let out = extract_file(&fp("schema.json"));
    // Top-level and nested schema keys
    assert_extract_has(&out, "title", "json_key");
    assert_extract_has(&out, "definitions", "json_key");
    assert_extract_has(&out, "properties", "json_key");
}

#[test]
fn empty_json_emits_zero_nodes_and_edges() {
    // empty.json contains `{}` - a valid empty object with no keys
    let out = extract_file(&fp("empty.json"));
    assert!(out.nodes.is_empty(), "empty.json produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.json produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.json");
    std::fs::write(&p, r#"{"key": "unclosed"#).unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_json_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.json");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

#[test]
fn empty_object_literal_is_valid_empty_case() {
    // Regression guard: `{}` must be valid JSON and produce zero nodes
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("empty.json");
    std::fs::write(&p, "{}").unwrap();
    let out = extract_file(&p);
    assert!(out.nodes.is_empty(), "{{}} produced nodes: {:#?}", out.nodes);
}

// ---------- Tier 2: full pipeline ----------
//
// JSON (.json) is in CODE_EXTENSIONS and is processed by the pipeline by default.

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_json_key_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // Use keys that are unique across the fixture to avoid ambiguous-dedup failures.
    // "definitions" only appears in schema.json; "description" only in config.json.
    assert_node(&g, "definitions", "json_key");
    assert_node(&g, "description", "json_key");
    // "title" is also unique to schema.json
    assert_node(&g, "title", "json_key");
}

#[test]
fn pipeline_emits_ref_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_ref = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "references");
    assert!(has_ref, "expected at least one references edge in pipeline output");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // config.json: 12 keys, schema.json: 14 keys = 26 total; dedup may merge same-label keys
    const FLOOR: usize = 10;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_config_ref_targets_schema_ref_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // The $ref node in config.json should have a references edge to ref::schema.json#/definitions/Config
    let has_schema_ref = g.graph.edge_references().any(|e| {
        e.weight().relation == "references"
            && g.graph[e.target()].label.contains("schema.json")
    });
    assert!(
        has_schema_ref,
        "expected references edge targeting schema.json in pipeline graph"
    );
}
