//! Graph connectivity invariant: extraction + dedup must never leave a
//! node with no edges. Every definition hangs off its file via `contains`,
//! imports and qualified calls attach through extern nodes, and dedup
//! redirects those externs onto real definitions where one exists.

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use petgraph::Direction;
use std::path::{Path, PathBuf};

fn fixture(name: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join(name)
}

#[test]
fn python_fixture_has_no_isolated_nodes() {
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(fixture("python-mini-cli"));
    cfg.out_root = out.path().to_path_buf();
    let result = Pipeline::new(cfg).run().unwrap();

    let g = &result.graph.graph;
    let isolated: Vec<String> = g
        .node_indices()
        .filter(|&ni| {
            g.neighbors_directed(ni, Direction::Incoming).count() == 0
                && g.neighbors_directed(ni, Direction::Outgoing).count() == 0
        })
        .map(|ni| g[ni].label.clone())
        .collect();
    assert!(
        isolated.is_empty(),
        "isolated nodes in python fixture: {isolated:?}"
    );
}

#[test]
fn python_cross_file_calls_resolve_to_definitions() {
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(fixture("python-mini-cli"));
    cfg.out_root = out.path().to_path_buf();
    let result = Pipeline::new(cfg).run().unwrap();

    let json = result.graph.to_json_value();
    let edges = json["edges"].as_array().unwrap();
    let has_edge = |src_end: &str, rel: &str, tgt_end: &str| {
        edges.iter().any(|e| {
            e["source"].as_str().unwrap().ends_with(src_end)
                && e["relation"] == rel
                && e["target"].as_str().unwrap().ends_with(tgt_end)
        })
    };

    // main() calls a function defined in a sibling module.
    assert!(
        has_edge("__main__.py::main", "calls", "util.py::banner"),
        "main -> banner call did not resolve"
    );
    // Imported bare name resolves through the extern to the definition.
    assert!(
        has_edge("hello.py::run", "calls", "util.py::say"),
        "run -> say call did not resolve"
    );
    // Dotted import resolved onto the definition, not a phantom extern.
    assert!(
        has_edge("hello.py", "imports", "util.py::say"),
        "hello.py import did not dedup onto util.py::say"
    );
    // Definitions anchor to their file.
    assert!(
        has_edge("util.py", "contains", "util.py::say"),
        "missing contains edge for util.py::say"
    );
}
