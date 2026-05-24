//! Unit tests for the watch-mode event filter.

use std::path::PathBuf;
use std::time::Instant;

use notify::event::{CreateKind, ModifyKind};
use notify::{Event, EventKind};
use notify_debouncer_full::DebouncedEvent;

use super::events_warrant_rebuild;

fn evt(kind: EventKind, paths: Vec<PathBuf>) -> DebouncedEvent {
    DebouncedEvent {
        event: Event { kind, paths, attrs: Default::default() },
        time: Instant::now(),
    }
}

#[test]
fn code_file_change_triggers_rebuild() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/src/main.rs")],
    );
    assert!(events_warrant_rebuild(&[e], &out));
}

#[test]
fn changes_inside_output_dir_are_ignored() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/graphy-out/graph.json")],
    );
    assert!(!events_warrant_rebuild(&[e], &out));
}

#[test]
fn cache_writes_are_ignored() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Create(CreateKind::File),
        vec![PathBuf::from("/proj/graphy-out/.cache/abc.json")],
    );
    assert!(!events_warrant_rebuild(&[e], &out));
}

#[test]
fn non_code_extensions_do_not_trigger_rebuild() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/notes.org")],
    );
    assert!(!events_warrant_rebuild(&[e], &out));
}

#[test]
fn mixed_paths_trigger_when_any_relevant_path_present() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![
            PathBuf::from("/proj/graphy-out/graph.html"),
            PathBuf::from("/proj/src/lib.rs"),
        ],
    );
    assert!(events_warrant_rebuild(&[e], &out));
}

#[test]
fn doc_extension_triggers_rebuild() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/README.md")],
    );
    assert!(events_warrant_rebuild(&[e], &out));
}

#[test]
fn access_only_events_are_ignored() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Access(notify::event::AccessKind::Read),
        vec![PathBuf::from("/proj/src/main.rs")],
    );
    assert!(!events_warrant_rebuild(&[e], &out));
}

#[test]
fn empty_event_list_does_not_trigger() {
    let out = PathBuf::from("/proj/graphy-out");
    assert!(!events_warrant_rebuild(&[], &out));
}

#[test]
fn uppercase_extension_handled_case_insensitively() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/Module.SWIFT")],
    );
    assert!(events_warrant_rebuild(&[e], &out));
}

#[test]
fn unknown_extension_does_not_trigger() {
    let out = PathBuf::from("/proj/graphy-out");
    let e = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![PathBuf::from("/proj/binary.bin")],
    );
    assert!(!events_warrant_rebuild(&[e], &out));
}

#[test]
fn handle_event_batch_skips_when_no_relevant_change() {
    use crate::pipeline::PipelineConfig;
    use super::handle_event_batch;
    let dir = tempfile::tempdir().unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let out_dir = dir.path().join("graphy-out");
    let result = handle_event_batch(&cfg, &out_dir, &[]);
    assert!(result.is_none());
}

#[test]
fn handle_event_batch_runs_pipeline_when_code_changes() {
    use std::fs;
    use crate::pipeline::PipelineConfig;
    use super::handle_event_batch;
    let dir = tempfile::tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let out_dir = dir.path().join("graphy-out");
    let event = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![dir.path().join("a.rs")],
    );
    let result = handle_event_batch(&cfg, &out_dir, &[event])
        .expect("rebuild should have run");
    let outputs = result.expect("pipeline should have succeeded");
    assert!(outputs.analysis.node_count >= 1);
}

#[test]
fn handle_event_batch_surfaces_pipeline_error() {
    use std::fs;
    use crate::pipeline::PipelineConfig;
    use super::handle_event_batch;
    // Force the pipeline write to fail by pre-creating graph.json as a directory.
    let dir = tempfile::tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let out_root = dir.path().to_path_buf();
    fs::create_dir_all(out_root.join("graphy-out").join("graph.json")).unwrap();
    let mut cfg = PipelineConfig::new(dir.path());
    cfg.out_root = out_root.clone();
    let out_dir = out_root.join("graphy-out");
    let event = evt(
        EventKind::Modify(ModifyKind::Any),
        vec![dir.path().join("a.rs")],
    );
    let result = handle_event_batch(&cfg, &out_dir, &[event])
        .expect("rebuild should have run");
    assert!(result.is_err(), "expected pipeline error path");
}
