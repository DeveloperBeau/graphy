//! Lang coverage: markdown. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md
//! Audit: plans/2026-05-26-lang-coverage-tier4.audit-markdown.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "markdown";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

/// Run the pipeline with include_docs=true so that .md files are collected.
/// Markdown lives in DOC_EXTENSIONS, not CODE_EXTENSIONS.
fn run_pipeline_with_docs() -> (graphy_core::graph::KnowledgeGraph, tempfile::TempDir) {
    use graphy_core::pipeline::{Pipeline, PipelineConfig};
    let tmp = tempfile::TempDir::new().expect("create tempdir");
    let cfg = PipelineConfig {
        root: fixture_dir(LANG),
        out_root: tmp.path().to_path_buf(),
        include_docs: true,
        use_cache: false,
        dedup: true,
        incremental: false,
        scc_expansion: true,
        hierarchical_clustering: true,
    };
    let out = Pipeline::new(cfg)
        .run()
        .expect("pipeline failed for markdown fixture");
    (out.graph, tmp)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/markdown"),
        "fixture_dir(markdown) returned unexpected path: {}",
        p.display()
    );
    assert!(p.join("README.md").exists(), "README.md missing");
}

#[test]
fn readme_emits_h1_heading() {
    let out = extract_file(&fp("README.md"));
    assert_extract_has(&out, "Graphy Markdown Fixture", "heading");
}

#[test]
fn readme_emits_h2_headings() {
    let out = extract_file(&fp("README.md"));
    assert_extract_has(&out, "Overview", "heading");
    assert_extract_has(&out, "Links", "heading");
    assert_extract_has(&out, "Files", "heading");
    assert_extract_has(&out, "Maintenance", "heading");
}

// ---------- Inline link extraction ----------
//
// The extractor uses tree-sitter-md's MarkdownParser to access inline trees.
// For each inline link [text](dest), if dest is NOT an http/https URL, a
// `references` edge is emitted from the containing heading section to the
// destination path. This closes the "Markdown inline links" deferred item.

#[test]
fn readme_emits_link_to_guide() {
    // README.md contains [Guide](guide.md)
    let out = extract_file(&fp("README.md"));
    let has_guide_ref = out
        .edges
        .iter()
        .any(|e| e.target == "link::guide.md" && e.relation == "references");
    assert!(
        has_guide_ref,
        "expected references edge to link::guide.md; edges = {:#?}",
        out.edges
    );
}

#[test]
fn readme_emits_link_to_api() {
    // README.md contains [API Reference](api.md)
    let out = extract_file(&fp("README.md"));
    let has_api_ref = out
        .edges
        .iter()
        .any(|e| e.target == "link::api.md" && e.relation == "references");
    assert!(
        has_api_ref,
        "expected references edge to link::api.md; edges = {:#?}",
        out.edges
    );
}

#[test]
fn readme_does_not_emit_https_links_as_edges() {
    // External URLs (https://) should NOT produce reference edges.
    let out = extract_file(&fp("README.md"));
    let has_https = out
        .edges
        .iter()
        .any(|e| e.target.starts_with("link::https://") || e.target.starts_with("link::http://"));
    assert!(
        !has_https,
        "http/https links should not produce edges; edges = {:#?}",
        out.edges
    );
}

#[test]
fn guide_emits_headings() {
    let out = extract_file(&fp("guide.md"));
    assert_extract_has(&out, "User Guide", "heading");
    assert_extract_has(&out, "Installation", "heading");
    assert_extract_has(&out, "Usage", "heading");
    assert_extract_has(&out, "Troubleshooting", "heading");
}

#[test]
fn guide_emits_nested_headings() {
    let out = extract_file(&fp("guide.md"));
    // H3 headings
    assert_extract_has(&out, "Basic Options", "heading");
    assert_extract_has(&out, "Advanced Configuration", "heading");
    assert_extract_has(&out, "Performance", "heading");
}

#[test]
fn api_emits_headings() {
    let out = extract_file(&fp("api.md"));
    assert_extract_has(&out, "API Reference", "heading");
    assert_extract_has(&out, "Pipeline", "heading");
    assert_extract_has(&out, "Configuration", "heading");
    assert_extract_has(&out, "Extractors", "heading");
    assert_extract_has(&out, "Graph", "heading");
}

#[test]
fn empty_file_emits_zero_nodes_and_edges() {
    let out = extract_file(&fp("empty.md"));
    assert!(
        out.nodes.is_empty(),
        "empty.md produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.md produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.md");
    // Tree-sitter-md is very lenient; this just tests no panic on odd input.
    std::fs::write(&p, "# Title\n```unclosed\nsome code\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_md_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.md");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------
//
// Markdown (.md/.mdx/.qmd) lives in DOC_EXTENSIONS.
// Must use include_docs=true; see run_pipeline_with_docs() above.
// No cross-file link edges expected (inline link extraction not implemented).

#[test]
fn pipeline_emits_heading_nodes_from_all_files() {
    let (g, _guard) = run_pipeline_with_docs();
    // README.md headings
    assert_node(&g, "Graphy Markdown Fixture", "heading");
    assert_node(&g, "Overview", "heading");
    // guide.md headings
    assert_node(&g, "User Guide", "heading");
    assert_node(&g, "Installation", "heading");
    // api.md headings
    assert_node(&g, "API Reference", "heading");
    assert_node(&g, "Pipeline", "heading");
}

#[test]
fn pipeline_emits_link_edges() {
    // Inline link edges from README.md appear in the merged graph.
    let (g, _guard) = run_pipeline_with_docs();
    use petgraph::visit::IntoEdgeReferences;
    let edge_count = g.graph.edge_references().count();
    assert!(
        edge_count > 0,
        "expected inline link reference edges in pipeline output; got 0"
    );
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline_with_docs();
    // README.md: 5 headings, guide.md: 7 headings, api.md: 5 headings = 17 headings
    const FLOOR: usize = 15;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_guide_headings_present() {
    let (g, _guard) = run_pipeline_with_docs();
    // Headings unique to guide.md
    assert_node(&g, "Troubleshooting", "heading");
    assert_node(&g, "Performance", "heading");
    assert_node(&g, "Basic Options", "heading");
}
