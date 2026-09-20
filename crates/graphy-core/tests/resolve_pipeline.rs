//! End-to-end proof that `crate::resolve::CallIndex` is wired into all three
//! build paths (`Pipeline::run`'s full path, `incremental::update_graph`'s
//! warm path, and `incremental::run_full`'s fallback), not merely defined.

use std::fs;
use std::path::{Path, PathBuf};

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use tempfile::tempdir;

fn fixture(rel: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage")
        .join(rel)
}

fn assert_no_unresolved(graph_json: &serde_json::Value, label: &str) {
    let edges = graph_json["edges"].as_array().unwrap();
    for e in edges {
        assert_ne!(
            e["relation"].as_str().unwrap(),
            "calls?unresolved",
            "{label}: an unresolved sentinel edge reached the graph: {e}"
        );
    }
    let nodes = graph_json["nodes"].as_array().unwrap();
    for n in nodes {
        let id = n["id"].as_str().unwrap();
        assert!(
            !id.starts_with("unresolved::"),
            "{label}: an unresolved sentinel node reached the graph: {id}"
        );
    }
}

#[test]
fn full_build_leaves_no_unresolved_relation() {
    for lang in ["swift", "java", "ruby"] {
        let out = tempdir().unwrap();
        let mut cfg = PipelineConfig::new(fixture(lang));
        cfg.out_root = out.path().to_path_buf();
        cfg.incremental = false;
        let result = Pipeline::new(cfg).run().unwrap();
        assert_no_unresolved(&result.graph.to_json_value(), lang);
    }
}

#[test]
fn warm_incremental_run_matches_the_cold_run() {
    let out = tempdir().unwrap();
    let mut cfg1 = PipelineConfig::new(fixture("java"));
    cfg1.out_root = out.path().to_path_buf();
    let r1 = Pipeline::new(cfg1.clone()).run().unwrap();

    let mut cfg2 = PipelineConfig::new(fixture("java"));
    cfg2.out_root = out.path().to_path_buf();
    let r2 = Pipeline::new(cfg2).run().unwrap();

    let calls_pairs = |v: &serde_json::Value| -> Vec<(String, String)> {
        v["edges"]
            .as_array()
            .unwrap()
            .iter()
            .filter(|e| e["relation"] == "calls")
            .map(|e| {
                (
                    e["source"].as_str().unwrap().to_string(),
                    e["target"].as_str().unwrap().to_string(),
                )
            })
            .collect()
    };
    let mut p1 = calls_pairs(&r1.graph.to_json_value());
    let mut p2 = calls_pairs(&r2.graph.to_json_value());
    p1.sort();
    p2.sort();
    assert!(!p1.is_empty(), "expected at least one calls edge");
    assert_eq!(p1, p2, "warm run's calls edges diverged from the cold run");
}

#[test]
fn warm_incremental_run_resolves_a_newly_added_files_call() {
    // `warm_incremental_run_matches_the_cold_run` above re-runs the pipeline
    // over an *unchanged* file set, so its second run's `part.uncached` (and
    // therefore `fresh`) is empty and never exercises the resolve pass over
    // freshly extracted files in `incremental::update_graph`. This test adds
    // a new file between runs so the warm path's `fresh` is non-empty.
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("helpers.rs"),
        "pub fn format_name(s: &str) -> String { s.to_string() }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();

    fs::write(
        dir.path().join("service.rs"),
        "pub fn run() { format_name(\"x\"); }\n",
    )
    .unwrap();
    let result = Pipeline::new(cfg).run().unwrap();

    let json = result.graph.to_json_value();
    let edges = json["edges"].as_array().unwrap();
    let has_edge = edges.iter().any(|e| {
        e["relation"] == "calls"
            && e["source"].as_str().unwrap().ends_with("service.rs::run")
            && e["target"]
                .as_str()
                .unwrap()
                .ends_with("helpers.rs::format_name")
    });
    assert!(
        has_edge,
        "newly added file's cross-file call did not resolve on the warm \
         incremental run; edges = {edges:#?}"
    );
}

#[test]
fn run_full_path_resolves() {
    let out = tempdir().unwrap();
    let mut cfg = PipelineConfig::new(fixture("rust"));
    cfg.out_root = out.path().to_path_buf();
    let _ = Pipeline::new(cfg.clone()).run().unwrap();

    // Corrupt graph.json so `load_prior_graph` returns None while the cache
    // manifest stays valid, forcing `incremental::run_full`.
    let graph_path = out.path().join("graphy-out").join("graph.json");
    fs::write(&graph_path, "{").unwrap();

    let result = Pipeline::new(cfg).run().unwrap();
    let json = result.graph.to_json_value();
    let has_edge = json["edges"].as_array().unwrap().iter().any(|e| {
        e["relation"] == "calls"
            && e["source"].as_str().unwrap().ends_with("service.rs::run")
            && e["target"]
                .as_str()
                .unwrap()
                .ends_with("helpers.rs::format_name")
    });
    assert!(
        has_edge,
        "run_full fallback did not resolve the cross-file call: {json}"
    );
}
