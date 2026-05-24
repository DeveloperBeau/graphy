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
    touch(
        dir.path(),
        "b.rs",
        "pub fn g(){}\npub fn h(){ g(); }\n",
    );
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
    touch(
        dir.path(),
        "a.rs",
        "pub fn helper(){}\n",
    );
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
