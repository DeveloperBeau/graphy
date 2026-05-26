//! Lang coverage: yaml. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-yaml.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "yaml";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/yaml"),
        "fixture_dir(yaml) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("config.yaml").exists(), "config.yaml missing");
}

#[test]
fn config_emits_top_level_key_nodes() {
    let out = extract_file(&fp("config.yaml"));
    // Top-level keys: name, version, description, server, database, logging
    assert_extract_has(&out, "name", "yaml_key");
    assert_extract_has(&out, "version", "yaml_key");
    assert_extract_has(&out, "server", "yaml_key");
    assert_extract_has(&out, "database", "yaml_key");
    assert_extract_has(&out, "logging", "yaml_key");
}

#[test]
fn config_emits_nested_key_nodes() {
    let out = extract_file(&fp("config.yaml"));
    // Nested keys under server: host, port, debug
    assert_extract_has(&out, "host", "yaml_key");
    assert_extract_has(&out, "port", "yaml_key");
    assert_extract_has(&out, "debug", "yaml_key");
}

#[test]
fn anchors_emits_anchor_key_nodes() {
    let out = extract_file(&fp("anchors.yaml"));
    // Top-level anchored mapping: defaults, production, staging
    assert_extract_has(&out, "defaults", "yaml_key");
    assert_extract_has(&out, "production", "yaml_key");
    assert_extract_has(&out, "staging", "yaml_key");
}

#[test]
fn anchors_emits_nested_anchor_fields() {
    let out = extract_file(&fp("anchors.yaml"));
    // Keys inside defaults: retries, timeout, enabled
    assert_extract_has(&out, "retries", "yaml_key");
    assert_extract_has(&out, "timeout", "yaml_key");
    assert_extract_has(&out, "enabled", "yaml_key");
}

// ---------- Anchor/alias reference edges ----------
//
// Anchor/alias extraction is now implemented. The extractor emits `references`
// edges from alias users back to the anchored key. This closes the YAML
// anchor/alias deferred item.

#[test]
fn anchors_production_references_defaults() {
    // `production` uses `<<: *defaults` so it should reference the `defaults` key.
    let out = extract_file(&fp("anchors.yaml"));
    assert_extract_edge(&out, "production", "defaults", "references");
}

#[test]
fn anchors_staging_references_defaults() {
    // `staging` uses `<<: *defaults` similarly.
    let out = extract_file(&fp("anchors.yaml"));
    assert_extract_edge(&out, "staging", "defaults", "references");
}

#[test]
fn anchors_emits_references_edges() {
    // At least one references edge exists from anchors.yaml.
    let out = extract_file(&fp("anchors.yaml"));
    assert!(
        !out.edges.is_empty(),
        "expected anchor/alias reference edges from anchors.yaml; none found"
    );
    let refs: Vec<_> = out.edges.iter().filter(|e| e.relation == "references").collect();
    assert!(!refs.is_empty(), "expected references edges; got: {:#?}", out.edges);
}

#[test]
fn config_emits_no_edges() {
    // config.yaml has no anchors/aliases; still expects no edges.
    let out = extract_file(&fp("config.yaml"));
    assert!(
        out.edges.is_empty(),
        "expected no edges from config.yaml; edges = {:#?}",
        out.edges
    );
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.yaml"));
    assert!(out.nodes.is_empty(), "empty.yaml produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.yaml produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.yaml");
    std::fs::write(&p, "key: {\n  unclosed: [").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_yaml_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.yaml");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// YAML (.yaml/.yml) has been added to CODE_EXTENSIONS so the pipeline picks
// it up by default (include_docs=false is sufficient).
// No cross-file edges expected; the pipeline collects yaml_key nodes from all files.

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_emits_yaml_key_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // Use keys unique to specific files to avoid ambiguous-dedup failures.
    // "server", "database", "logging" only appear in config.yaml
    assert_node(&g, "server", "yaml_key");
    assert_node(&g, "database", "yaml_key");
    assert_node(&g, "logging", "yaml_key");
}

#[test]
fn pipeline_emits_anchor_section_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // "defaults", "production", "staging" only appear in anchors.yaml
    assert_node(&g, "defaults", "yaml_key");
    assert_node(&g, "production", "yaml_key");
    assert_node(&g, "staging", "yaml_key");
}

#[test]
fn pipeline_emits_anchor_alias_edges() {
    // Anchor/alias edges from anchors.yaml appear in the merged graph.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_edge(&g, "production", "defaults", "references");
    assert_edge(&g, "staging", "defaults", "references");
}

#[test]
fn pipeline_emits_references_edges() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let edge_count = g.graph.edge_references().count();
    assert!(
        edge_count > 0,
        "expected anchor/alias reference edges in pipeline output; got 0"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // config.yaml: 14 keys, anchors.yaml: 12 keys = 26 total; dedup merges duplicates
    // Conservative floor: at least 15 distinct labels
    const FLOOR: usize = 15;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
