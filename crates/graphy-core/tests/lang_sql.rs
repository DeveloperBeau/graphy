//! Lang coverage: sql. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-sql.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "sql";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/sql"),
        "fixture_dir(sql) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("schema.sql").exists(), "schema.sql missing");
}

#[test]
fn schema_emits_create_table_nodes() {
    let out = extract_file(&fp("schema.sql"));
    // Three tables: users, posts, comments
    assert_extract_has(&out, "users", "table");
    assert_extract_has(&out, "posts", "table");
    assert_extract_has(&out, "comments", "table");
}

#[test]
fn schema_emits_create_index_nodes() {
    let out = extract_file(&fp("schema.sql"));
    assert_extract_has(&out, "idx_posts_user_id", "index");
    assert_extract_has(&out, "idx_comments_post_id", "index");
}

#[test]
fn schema_emits_create_view_node() {
    let out = extract_file(&fp("schema.sql"));
    assert_extract_has(&out, "active_users", "view");
}

#[test]
fn schema_emits_no_edges() {
    // The SQL extractor is DDL-only; no FK or JOIN edges are extracted.
    let out = extract_file(&fp("schema.sql"));
    assert!(
        out.edges.is_empty(),
        "expected no edges from schema.sql (DDL-only extractor); edges = {:#?}",
        out.edges
    );
}

#[test]
fn queries_emits_no_nodes() {
    // DML (SELECT/INSERT/UPDATE/DELETE) does not produce graph nodes.
    let out = extract_file(&fp("queries.sql"));
    assert!(
        out.nodes.is_empty(),
        "expected no nodes from queries.sql (DML only); nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.sql"));
    assert!(out.nodes.is_empty(), "empty.sql produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.sql produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.sql");
    std::fs::write(&p, "CREATE TABLE ( UNCLOSED").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_sql_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.sql");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// SQL (.sql) is in CODE_EXTENSIONS and is processed by the pipeline by default.
// No cross-file edges are expected; the pipeline collects DDL nodes from all files.

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_table_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "users", "table");
    assert_node(&g, "posts", "table");
    assert_node(&g, "comments", "table");
}

#[test]
fn pipeline_emits_view_and_index_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "active_users", "view");
    assert_node(&g, "idx_posts_user_id", "index");
    assert_node(&g, "idx_comments_post_id", "index");
}

#[test]
fn pipeline_emits_no_edges_for_sql_fixture() {
    // SQL extractor emits no edges; pipeline should have zero edges for this fixture.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let edge_count = g.graph.edge_references().count();
    assert_eq!(
        edge_count, 0,
        "expected 0 edges for SQL-only fixture; got {edge_count}"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // 3 tables + 2 indexes + 1 view = 6 minimum
    const FLOOR: usize = 6;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
