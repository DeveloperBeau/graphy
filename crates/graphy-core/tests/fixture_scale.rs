//! Small / medium / large real-project fixtures for every supported
//! language, with per-project ground truth.
//!
//! `fixtures/scale/<lang>/{small,medium,large}/` each hold a complete,
//! coherent program (the same three tools in every language: a text
//! printer, a calculator, and an encryption testing tool with a
//! file-backed results store), plus an `expected.json` stating facts the
//! graph MUST contain — specific definitions and specific edges — derived
//! from the code. The harness runs the full pipeline per project and
//! checks the graph against those facts, so it verifies the extractor got
//! the right answer, not merely that it produced output.

use std::collections::HashMap;
use std::path::{Path, PathBuf};

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use petgraph::Direction;
use serde::Deserialize;

const LANGS: &[&str] = &[
    "bash",
    "c",
    "cpp",
    "csharp",
    "css",
    "dart",
    "elixir",
    "erlang",
    "fortran",
    "go",
    "groovy",
    "haskell",
    "html",
    "java",
    "javascript",
    "json",
    "julia",
    "kotlin",
    "lua",
    "markdown",
    "objc",
    "ocaml",
    "pascal",
    "perl",
    "php",
    "powershell",
    "python",
    "r",
    "ruby",
    "rust",
    "scala",
    "sql",
    "svelte",
    "swift",
    "toml",
    "typescript",
    "verilog",
    "yaml",
    "zig",
];

const SIZES: &[&str] = &["small", "medium", "large"];

#[derive(Deserialize)]
struct Expected {
    min_nodes: usize,
    #[serde(default)]
    nodes: Vec<ExpectedNode>,
    #[serde(default)]
    edges: Vec<ExpectedEdge>,
}

#[derive(Deserialize)]
struct ExpectedNode {
    label: String,
    kind: String,
}

#[derive(Deserialize)]
struct ExpectedEdge {
    source_ends: String,
    relation: String,
    target_ends: String,
}

fn project_dir(lang: &str, size: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("scale")
        .join(lang)
        .join(size)
}

struct GraphFacts {
    node_count: usize,
    /// (label, kind-with-ambiguity-stripped) pairs.
    nodes: Vec<(String, String)>,
    /// (source id, relation, target id) triples.
    edges: Vec<(String, String, String)>,
    isolated: Vec<String>,
}

fn run_project(dir: &Path) -> GraphFacts {
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(dir);
    cfg.out_root = out.path().to_path_buf();
    cfg.include_docs = true;
    let result = Pipeline::new(cfg)
        .run()
        .unwrap_or_else(|e| panic!("pipeline failed for {}: {e:#}", dir.display()));

    let g = &result.graph.graph;
    let id_of: HashMap<_, _> = result
        .graph
        .by_id
        .iter()
        .map(|(id, &idx)| (idx, id.clone()))
        .collect();

    let nodes = g
        .node_indices()
        .map(|ni| {
            let d = &g[ni];
            (d.label.clone(), d.kind.clone().unwrap_or_default())
        })
        .collect();
    let edges = g
        .edge_indices()
        .map(|e| {
            let (s, t) = g.edge_endpoints(e).unwrap();
            (id_of[&s].clone(), g[e].relation.clone(), id_of[&t].clone())
        })
        .collect();
    let isolated = g
        .node_indices()
        .filter(|&ni| {
            g.neighbors_directed(ni, Direction::Incoming).count() == 0
                && g.neighbors_directed(ni, Direction::Outgoing).count() == 0
        })
        .map(|ni| g[ni].label.clone())
        .collect();

    GraphFacts {
        node_count: g.node_count(),
        nodes,
        edges,
        isolated,
    }
}

fn check_project(lang: &str, size: &str, failures: &mut Vec<String>) {
    let dir = project_dir(lang, size);
    if !dir.is_dir() {
        failures.push(format!("{lang}/{size}: fixture project missing"));
        return;
    }
    let expected_path = dir.join("expected.json");
    let expected: Expected = match std::fs::read_to_string(&expected_path)
        .map_err(|e| e.to_string())
        .and_then(|s| serde_json::from_str(&s).map_err(|e| e.to_string()))
    {
        Ok(e) => e,
        Err(e) => {
            failures.push(format!("{lang}/{size}: bad expected.json: {e}"));
            return;
        }
    };

    let facts = run_project(&dir);

    if facts.node_count < expected.min_nodes {
        failures.push(format!(
            "{lang}/{size}: {} nodes, expected at least {}",
            facts.node_count, expected.min_nodes
        ));
    }
    for want in &expected.nodes {
        if !facts
            .nodes
            .iter()
            .any(|(l, k)| l == &want.label && k == &want.kind)
        {
            failures.push(format!(
                "{lang}/{size}: missing node {}:{}",
                want.label, want.kind
            ));
        }
    }
    for want in &expected.edges {
        if !facts.edges.iter().any(|(s, r, t)| {
            s.ends_with(&want.source_ends) && r == &want.relation && t.ends_with(&want.target_ends)
        }) {
            failures.push(format!(
                "{lang}/{size}: missing edge {} -[{}]-> {}",
                want.source_ends, want.relation, want.target_ends
            ));
        }
    }
    if !facts.isolated.is_empty() {
        let mut sample = facts.isolated.clone();
        sample.truncate(5);
        failures.push(format!(
            "{lang}/{size}: {} isolated nodes, e.g. {sample:?}",
            facts.isolated.len()
        ));
    }
}

fn run_size_for_all(size: &str) {
    let mut failures = Vec::new();
    for lang in LANGS {
        check_project(lang, size, &mut failures);
    }
    assert!(failures.is_empty(), "{size} failures:\n{failures:#?}");
}

#[test]
fn small_projects_match_expectations() {
    run_size_for_all("small");
}

#[test]
fn medium_projects_match_expectations() {
    run_size_for_all("medium");
}

#[test]
fn large_projects_match_expectations() {
    run_size_for_all("large");
}

#[test]
fn sizes_grow_per_language() {
    let mut failures = Vec::new();
    for lang in LANGS {
        let counts: Vec<Option<usize>> = SIZES
            .iter()
            .map(|s| {
                let dir = project_dir(lang, s);
                dir.is_dir().then(|| run_project(&dir).node_count)
            })
            .collect();
        if let (Some(s), Some(m), Some(l)) = (counts[0], counts[1], counts[2]) {
            if !(s < m && m < l) {
                failures.push(format!(
                    "{lang}: node counts do not grow small<medium<large: {s} -> {m} -> {l}"
                ));
            }
        } else {
            failures.push(format!("{lang}: missing size dirs {counts:?}"));
        }
    }
    assert!(failures.is_empty(), "growth failures:\n{failures:#?}");
}
