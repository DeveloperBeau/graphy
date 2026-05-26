//! Lang coverage: svelte. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! The Svelte extractor surfaces `script_element` and `style_element` nodes
//! as `svelte_block` kind. It does not descend into JS inside the script block
//! to emit function/import nodes. `inherits`, `implements`, and `calls` are N/A.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "svelte";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/svelte"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/Service.svelte").exists());
}

#[test]
fn service_emits_script_block_node() {
    let out = extract_file(&fp("src/Service.svelte"));
    let script_nodes: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("svelte_block") && n.label == "script")
        .collect();
    assert!(
        !script_nodes.is_empty(),
        "no script svelte_block node from Service.svelte; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn helpers_emits_script_block_node() {
    let out = extract_file(&fp("src/Helpers.svelte"));
    let script_nodes: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("svelte_block") && n.label == "script")
        .collect();
    assert!(
        !script_nodes.is_empty(),
        "no script svelte_block node from Helpers.svelte; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.svelte"));
    assert!(out.nodes.is_empty(), "empty.svelte produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.svelte produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.svelte");
    std::fs::write(&p, "<script>\n  let x = (((unclosed\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.svelte");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Deferred closure: script-block decomposition ----------

#[test]
fn service_emits_function_node_from_script() {
    let out = extract_file(&fp("src/Service.svelte"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.iter().any(|l| *l == "handleClick"),
        "function 'handleClick' not found in Service.svelte; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_import_node_from_script() {
    let out = extract_file(&fp("src/Service.svelte"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "Helpers import not found in Service.svelte; got {import_labels:?}"
    );
}

#[test]
fn helpers_svelte_emits_function_node_from_script() {
    let out = extract_file(&fp("src/Helpers.svelte"));
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        fn_labels.iter().any(|l| *l == "formatLabel"),
        "function 'formatLabel' not found in Helpers.svelte; got {fn_labels:?}"
    );
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_resolves_script_block_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // The pipeline should contain at least one svelte_block node (from .svelte files).
    // After dedup the kind may have a "?ambiguous" qualifier; match by prefix.
    let has_script = g
        .graph
        .node_weights()
        .any(|n| n.kind.as_deref().map(|k| k.starts_with("svelte_block")).unwrap_or(false));
    assert!(has_script, "no svelte_block nodes in pipeline graph; nodes = {:#?}", g.graph.node_weights().map(|n| (&n.label, &n.kind)).collect::<Vec<_>>());
}

#[test]
fn pipeline_also_processes_js_file() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // types.js is processed by the js_ts extractor and should produce function nodes
    let has_js = g
        .graph
        .node_weights()
        .any(|n| n.kind.as_deref() == Some("function") && n.label == "formatName");
    assert!(has_js, "formatName function node from types.js missing in pipeline graph");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 2;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
