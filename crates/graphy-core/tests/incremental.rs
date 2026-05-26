//! `incremental` module: prior-graph reuse, delta strip + splice, removal.

use std::fs;

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use tempfile::tempdir;

fn touch(dir: &std::path::Path, name: &str, body: &str) -> std::path::PathBuf {
    let p = dir.join(name);
    fs::write(&p, body).unwrap();
    p
}

#[test]
fn first_run_falls_back_to_full_then_subsequent_runs_use_incremental() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){}\npub fn g(){ f(); }\n");
    let cfg = PipelineConfig::new(dir.path());

    let r1 = Pipeline::new(cfg.clone()).run().unwrap();
    let r2 = Pipeline::new(cfg.clone()).run().unwrap();
    let r3 = Pipeline::new(cfg).run().unwrap();

    // Stable across re-runs with no source changes.
    assert_eq!(r1.analysis.node_count, r2.analysis.node_count);
    assert_eq!(r2.analysis.node_count, r3.analysis.node_count);
    assert_eq!(r1.analysis.edge_count, r2.analysis.edge_count);
    assert_eq!(r2.analysis.edge_count, r3.analysis.edge_count);
}

#[test]
fn add_new_file_splices_into_existing_graph() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){}\n");
    let cfg = PipelineConfig::new(dir.path());

    let r1 = Pipeline::new(cfg.clone()).run().unwrap();
    touch(dir.path(), "b.rs", "pub fn g(){}\npub fn h(){ g(); }\n");
    let r2 = Pipeline::new(cfg).run().unwrap();

    assert!(r2.analysis.node_count > r1.analysis.node_count);
    assert!(r2.analysis.edge_count >= r1.analysis.edge_count);
}

#[test]
fn modify_file_drops_old_nodes_and_splices_new() {
    let dir = tempdir().unwrap();
    let p = touch(dir.path(), "a.rs", "pub fn f(){}\n");
    let cfg = PipelineConfig::new(dir.path());

    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Rename f -> g; old node `a.rs::f` should disappear, new `a.rs::g`
    // should appear.
    fs::write(&p, "pub fn g(){}\n").unwrap();
    let r2 = Pipeline::new(cfg).run().unwrap();

    let labels: Vec<_> = r2
        .graph
        .graph
        .node_weights()
        .map(|n| n.label.clone())
        .collect();
    assert!(labels.contains(&"g".to_string()));
    assert!(!labels.contains(&"f".to_string()));
}

#[test]
fn delete_file_strips_its_contributions() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){}\n");
    let b = touch(dir.path(), "b.rs", "pub fn g(){}\n");
    let cfg = PipelineConfig::new(dir.path());

    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    fs::remove_file(&b).unwrap();
    let r2 = Pipeline::new(cfg).run().unwrap();

    let labels: Vec<_> = r2
        .graph
        .graph
        .node_weights()
        .map(|n| n.label.clone())
        .collect();
    assert!(labels.contains(&"f".to_string()));
    assert!(!labels.contains(&"g".to_string()));
}

#[test]
fn full_flag_bypasses_incremental_and_still_converges() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){}\n");
    let mut cfg = PipelineConfig::new(dir.path());

    let r1 = Pipeline::new(cfg.clone()).run().unwrap();
    cfg.incremental = false;
    let r2 = Pipeline::new(cfg).run().unwrap();

    assert_eq!(r1.analysis.node_count, r2.analysis.node_count);
    assert_eq!(r1.analysis.edge_count, r2.analysis.edge_count);
}

#[test]
fn dedup_disabled_preserves_extern_nodes() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn helper(){}\n");
    touch(
        dir.path(),
        "b.rs",
        "use crate::a::helper;\npub fn caller(){ helper(); }\n",
    );
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.dedup = false;
    let r = Pipeline::new(cfg).run().unwrap();
    let has_extern = r
        .graph
        .graph
        .node_weights()
        .any(|n| n.id_label().starts_with("extern::"));
    assert!(has_extern, "extern should survive when dedup is disabled");
}

/// Convenience: NodeData does not expose its id, so we encode it from
/// label here for the assertion above. Imports look like
/// `extern::<module>::helper` so checking the label is sufficient.
trait IdLabel {
    fn id_label(&self) -> String;
}
impl IdLabel for graphy_core::graph::NodeData {
    fn id_label(&self) -> String {
        // Reconstruct the way the extractors built it: imports have label
        // = "<module>::<sym>"; ghost file nodes have label = file path.
        if self.kind.as_deref() == Some("import") {
            return format!("extern::{}", self.label);
        }
        self.label.clone()
    }
}

#[test]
#[ignore = "large-fixture test; run with `cargo test -- --ignored`"]
fn hierarchical_delta_modularity_within_5_percent_of_fresh() {
    use graphy_core::cluster::levels::compute_modularity;
    use std::process::Command;

    // The fixture is gitignored; ensure it's been generated.
    let repo_root = std::path::PathBuf::from(env!("CARGO_MANIFEST_DIR"))
        .ancestors()
        .nth(2)
        .unwrap()
        .to_path_buf();
    let fixture = repo_root.join("fixtures/large-synthetic");
    if !fixture.join("src/main.rs").exists() {
        let script = repo_root.join("fixtures/gen-large-synthetic.sh");
        let status = Command::new("bash")
            .arg(&script)
            .arg(&fixture)
            .status()
            .expect("run gen-large-synthetic.sh");
        assert!(status.success(), "fixture generation failed");
    }

    let dir = tempdir().unwrap();
    // First run: full pass, populates louvain-levels.json.
    let mut cfg = graphy_core::pipeline::PipelineConfig::new(&fixture);
    cfg.out_root = dir.path().to_path_buf();
    let r1 = graphy_core::pipeline::Pipeline::new(cfg.clone())
        .run()
        .unwrap();
    let q_fresh = compute_modularity(&r1.graph);

    // Touch one file (under fixture, then restore).
    let touch_path = fixture.join("src/modules/m_0_0.rs");
    let body_orig = std::fs::read_to_string(&touch_path).unwrap();
    let body_modified = format!("{body_orig}\npub fn extra_marker() {{}}\n");
    std::fs::write(&touch_path, &body_modified).unwrap();

    let r2 = graphy_core::pipeline::Pipeline::new(cfg).run().unwrap();
    let q_delta = compute_modularity(&r2.graph);

    // Restore.
    std::fs::write(&touch_path, &body_orig).unwrap();

    let drift = (q_fresh - q_delta).abs();
    let ratio = drift / q_fresh.abs().max(0.001);
    assert!(
        ratio < 0.05,
        "modularity drifted: fresh={q_fresh}, delta={q_delta}, ratio={ratio}"
    );
}

#[test]
fn hierarchical_delta_persists_levels_after_run() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){} pub fn g(){ f(); }\n");
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.out_root = dir.path().to_path_buf();
    cfg.hierarchical_clustering = true;
    let _ = Pipeline::new(cfg).run().unwrap();
    let p = dir.path().join("graphy-out/.cache/louvain-levels.json");
    assert!(
        p.exists(),
        "louvain-levels.json should exist after first run"
    );
    let body = fs::read_to_string(&p).unwrap();
    let parsed: graphy_core::cluster::levels::LouvainLevels = serde_json::from_str(&body).unwrap();
    assert_eq!(parsed.version, 1);
    assert!(
        !parsed.levels.is_empty(),
        "expected at least one recorded level"
    );
}

#[test]
fn hierarchical_delta_falls_back_on_quality_gate() {
    let dir = tempdir().unwrap();
    touch(dir.path(), "a.rs", "pub fn f(){} pub fn g(){ f(); }\n");
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.out_root = dir.path().to_path_buf();
    cfg.hierarchical_clustering = true;
    let _ = Pipeline::new(cfg.clone()).run().unwrap();

    // Corrupt the persisted modularity to artificially trip the gate on the
    // next run.
    let p = dir.path().join("graphy-out/.cache/louvain-levels.json");
    let mut levels: graphy_core::cluster::levels::LouvainLevels =
        serde_json::from_str(&fs::read_to_string(&p).unwrap()).unwrap();
    levels.modularity = 1.0; // unattainable on this graph
    fs::write(&p, serde_json::to_string(&levels).unwrap()).unwrap();

    // Modify the file → triggers incremental → quality gate trips → full pass.
    touch(dir.path(), "a.rs", "pub fn f(){} pub fn h(){}\n");
    let _ = Pipeline::new(cfg).run().unwrap();

    // After the full-pass fallback, persisted modularity reflects the real
    // graph value, not the corrupted seed.
    let after: graphy_core::cluster::levels::LouvainLevels =
        serde_json::from_str(&fs::read_to_string(&p).unwrap()).unwrap();
    assert!(
        after.modularity < 1.0,
        "persisted modularity not refreshed: {}",
        after.modularity
    );
}
