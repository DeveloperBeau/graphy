//! End-to-end pipeline integration tests.

use std::fs;

use graphy_core::{Pipeline, PipelineConfig};
use tempfile::tempdir;

#[test]
fn pipeline_run_writes_three_outputs() {
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("a.rs"),
        "pub fn f(){} pub fn g(){ f(); }\n",
    )
    .unwrap();
    fs::write(
        dir.path().join("b.py"),
        "def f(): pass\ndef g(): f()\n",
    )
    .unwrap();

    let mut cfg = PipelineConfig::new(dir.path());
    cfg.out_root = dir.path().into();
    let out = Pipeline::new(cfg).run().unwrap();

    assert!(out.paths.graph_json.exists());
    assert!(out.paths.report_md.exists());
    assert!(out.paths.graph_html.exists());
    assert!(out.files_scanned >= 2);
    assert!(out.analysis.node_count > 0);
}

#[test]
fn pipeline_idempotent_across_runs() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.out_root = dir.path().into();
    let a = Pipeline::new(cfg.clone()).run().unwrap();
    let b = Pipeline::new(cfg).run().unwrap();
    assert_eq!(a.analysis.node_count, b.analysis.node_count);
    assert_eq!(a.analysis.edge_count, b.analysis.edge_count);
}

#[test]
fn pipeline_empty_dir_is_safe() {
    let dir = tempdir().unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let out = Pipeline::new(cfg).run().unwrap();
    assert_eq!(out.files_scanned, 0);
    assert_eq!(out.analysis.node_count, 0);
}

#[test]
fn pipeline_with_include_docs_picks_up_markdown_headings_as_nodes() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("README.md"), "# hi\n## sub\n").unwrap();
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.include_docs = true;
    let out = Pipeline::new(cfg).run().unwrap();
    assert_eq!(out.files_scanned, 1);
    assert!(out.analysis.node_count >= 1);
}

#[test]
fn pipeline_second_run_hits_cache_for_unchanged_files() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    fs::write(dir.path().join("b.py"), "def g(): pass\n").unwrap();

    let cfg = PipelineConfig::new(dir.path());
    let first = Pipeline::new(cfg.clone()).run().unwrap();
    let second = Pipeline::new(cfg).run().unwrap();

    assert_eq!(first.files_cached, 0);
    assert_eq!(second.files_cached, second.files_scanned);
    assert_eq!(first.analysis.node_count, second.analysis.node_count);
}

#[test]
fn pipeline_with_cache_disabled_never_reports_cache_hits() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.use_cache = false;
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    let r = Pipeline::new(cfg).run().unwrap();
    assert_eq!(r.files_cached, 0);
}

#[test]
fn pipeline_cache_invalidated_when_file_changes() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "pub fn f(){}\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    fs::write(&p, "pub fn f(){}\npub fn g(){}\n").unwrap();
    let r = Pipeline::new(cfg).run().unwrap();
    assert_eq!(r.files_cached, 0, "modified file must not be served from cache");
    assert!(r.analysis.node_count > 1);
}

#[test]
fn pipeline_hostile_inputs_do_not_crash() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("broken.rs"), "fn (((\n").unwrap();
    fs::write(dir.path().join("zero.rs"), "").unwrap();
    fs::write(dir.path().join("binary.rs"), [0xff_u8; 4096]).unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg).run().unwrap();
}
