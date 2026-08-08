//! Small / medium / large fixture runs for every supported language.
//!
//! Small runs the language's `fixtures/lang-coverage/<lang>/` tree as-is.
//! Medium and large replicate that tree into a tempdir (50x and 200x copies
//! under `copy_<i>/`), so scale grows without committing generated bulk to
//! the repo. Every size runs the full pipeline and asserts:
//!
//! - the pipeline succeeds,
//! - node/edge counts scale monotonically with size,
//! - no node is isolated, for every language including data/markup formats.

use std::collections::HashSet;
use std::fs;
use std::path::{Path, PathBuf};

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use petgraph::Direction;

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

fn lang_fixture(lang: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage")
        .join(lang)
}

fn copy_tree(src: &Path, dst: &Path) {
    fs::create_dir_all(dst).unwrap();
    for entry in fs::read_dir(src).unwrap() {
        let entry = entry.unwrap();
        let to = dst.join(entry.file_name());
        if entry.file_type().unwrap().is_dir() {
            copy_tree(&entry.path(), &to);
        } else {
            fs::copy(entry.path(), &to).unwrap();
        }
    }
}

/// Replicate the language fixture `copies` times under a tempdir and run
/// the pipeline over it. Returns (node_count, edge_count, isolated labels).
fn run_at_scale(lang: &str, copies: usize) -> (usize, usize, Vec<String>) {
    let src = lang_fixture(lang);
    assert!(src.is_dir(), "missing fixture dir for {lang}");

    let root = tempfile::tempdir().unwrap();
    for i in 0..copies {
        copy_tree(&src, &root.path().join(format!("copy_{i}")));
    }
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(root.path());
    cfg.out_root = out.path().to_path_buf();
    cfg.include_docs = true; // markdown fixtures are excluded otherwise
    let result = Pipeline::new(cfg)
        .run()
        .unwrap_or_else(|e| panic!("pipeline failed for {lang} x{copies}: {e:#}"));

    let g = &result.graph.graph;
    let isolated = g
        .node_indices()
        .filter(|&ni| {
            g.neighbors_directed(ni, Direction::Incoming).count() == 0
                && g.neighbors_directed(ni, Direction::Outgoing).count() == 0
        })
        .map(|ni| g[ni].label.clone())
        .collect();
    (g.node_count(), g.edge_count(), isolated)
}

fn run_size(copies: usize) {
    let mut failures: Vec<String> = Vec::new();
    for lang in LANGS {
        let (nodes, _edges, isolated) = run_at_scale(lang, copies);
        if nodes == 0 {
            failures.push(format!("{lang}: produced an empty graph"));
        }
        if !isolated.is_empty() {
            failures.push(format!("{lang}: isolated nodes {isolated:?}"));
        }
    }
    assert!(failures.is_empty(), "x{copies} failures:\n{failures:#?}");
}

#[test]
fn small_all_languages() {
    run_size(1);
}

#[test]
fn medium_all_languages() {
    run_size(50);
}

#[test]
fn large_all_languages() {
    run_size(200);
}

#[test]
fn node_counts_scale_monotonically() {
    // Sampled per-language: growing the tree must never shrink the graph.
    let checked: HashSet<&str> = ["python", "rust", "go", "swift", "kotlin", "zig"]
        .into_iter()
        .collect();
    for lang in LANGS.iter().filter(|l| checked.contains(**l)) {
        let (n1, e1, _) = run_at_scale(lang, 1);
        let (n50, e50, _) = run_at_scale(lang, 50);
        let (n200, e200, _) = run_at_scale(lang, 200);
        assert!(
            n1 <= n50 && n50 <= n200,
            "{lang}: node counts not monotonic: {n1} -> {n50} -> {n200}"
        );
        assert!(
            e1 <= e50 && e50 <= e200,
            "{lang}: edge counts not monotonic: {e1} -> {e50} -> {e200}"
        );
        assert!(
            n200 >= n1 * 100,
            "{lang}: 200x tree produced fewer than 100x nodes ({n1} -> {n200}) — replicas are being dropped"
        );
    }
}
