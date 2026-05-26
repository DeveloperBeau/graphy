//! Cycle-aware delta-Louvain: SCC wiring integration tests.
//!
//! Tests verify:
//! 1. An incremental run on a mutually-recursive module produces modularity
//!    within a reasonable range of a full Louvain baseline.
//! 2. The incremental path writes scc.json to the cache directory.

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use std::fs;
use tempfile::tempdir;

#[test]
fn delta_louvain_with_scc_produces_reasonable_modularity() {
    let dir = tempdir().unwrap();
    let rec_py = dir.path().join("rec.py");

    // 6-function mutually-recursive Python module: a→b→c→d→e→f→a.
    // All six are in a single strongly-connected component. Both full and
    // delta Louvain should find some non-trivial community structure.
    fs::write(
        &rec_py,
        "def a(): return b()\n\
         def b(): return c()\n\
         def c(): return d()\n\
         def d(): return e()\n\
         def e(): return f()\n\
         def f(): return a()\n",
    )
    .unwrap();

    // Baseline: from-scratch full run (writes graph.json but does not use it).
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.incremental = false;
    let baseline = Pipeline::new(cfg.clone()).run().unwrap();
    let baseline_q = graphy_core::cluster::modularity(&baseline.graph);

    // Sanity: the baseline graph has the 6 nodes we expect.
    assert_eq!(baseline.graph.node_count(), 6, "expected 6 nodes");

    // Touch the file (trivial change), then run the incremental path.
    // Because graph.json was written by the baseline run above, update_graph
    // will find a prior graph and apply delta-Louvain with SCC widening.
    fs::write(
        &rec_py,
        "def a(): return b()\n\
         def b(): return c()\n\
         def c(): return d()\n\
         def d(): return e()\n\
         def e(): return f()\n\
         def f(): return a()  # noop\n",
    )
    .unwrap();
    cfg.incremental = true;
    let delta = Pipeline::new(cfg).run().unwrap();
    let delta_q = graphy_core::cluster::modularity(&delta.graph);

    // The incremental graph should also have 6 nodes.
    assert_eq!(delta.graph.node_count(), 6, "expected 6 nodes after incremental run");

    // Both runs should find non-negative modularity (they found some structure).
    // We do not assert a tight numerical match because Louvain is a heuristic
    // and a small 6-node ring graph has several valid local optima with
    // modularity in the range [0, 0.5]. What matters is that delta-Louvain
    // is not catastrophically worse.
    assert!(
        delta_q >= -0.01,
        "delta-Louvain produced negative modularity {delta_q:.4}"
    );
    // Allow up to 20% absolute drift between the two heuristic runs.
    // A 6-node ring graph has valid local optima in [0, 0.5] so this is still
    // permissive, but tight enough to catch genuine regressions.
    let abs_diff = (baseline_q - delta_q).abs();
    assert!(
        abs_diff < 0.20,
        "modularity diverged too far: baseline={baseline_q:.4}, delta={delta_q:.4}, |diff|={abs_diff:.4}"
    );
}

#[test]
fn incremental_run_persists_scc_cache() {
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("rec.py"),
        "def a(): return b()\ndef b(): return a()\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    // First run: full build via pipeline (no prior graph.json).
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Second run: incremental path — should produce and persist scc.json.
    let _ = Pipeline::new(cfg).run().unwrap();
    let scc_path = dir
        .path()
        .join("graphy-out")
        .join(".cache")
        .join("scc.json");
    assert!(
        scc_path.exists(),
        "scc.json should persist after an incremental run"
    );
}

#[test]
fn full_rebuild_clears_stale_scc_cache() {
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("rec.py"),
        "def a(): return b()\ndef b(): return a()\n",
    )
    .unwrap();

    // First run: pipeline writes graph.json + (via the incremental path on
    // a subsequent run) scc.json. Force the incremental path explicitly by
    // running twice.
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    let scc_path = dir
        .path()
        .join("graphy-out")
        .join(".cache")
        .join("scc.json");
    assert!(scc_path.exists(), "scc.json must exist after incremental run");

    // Now stamp the file with garbage so we can detect a "reset" vs a "rewrite".
    fs::write(&scc_path, b"STALE_MARKER").unwrap();

    // Force the non-incremental path by deleting graph.json. Pipeline::run
    // will fall through to the full pipeline branch.
    let graph_json = dir.path().join("graphy-out").join("graph.json");
    if graph_json.exists() {
        fs::remove_file(&graph_json).unwrap();
    }

    let _ = Pipeline::new(cfg).run().unwrap();

    // After a full rebuild, the stale marker must be gone. Two valid outcomes:
    //   (a) the file is deleted, or
    //   (b) the file is rewritten with a fresh JSON payload (no STALE_MARKER).
    if scc_path.exists() {
        let contents = fs::read(&scc_path).unwrap();
        assert!(
            !contents.windows(b"STALE_MARKER".len()).any(|w| w == b"STALE_MARKER"),
            "scc.json must be reset on full rebuild; still contains stale marker"
        );
    }
}
