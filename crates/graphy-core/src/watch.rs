//! Filesystem watch mode.
//!
//! `watch(cfg)` blocks the current thread and re-runs the pipeline each time
//! a relevant file under `cfg.root` changes. Events are debounced so editor
//! saves that touch several files in quick succession produce a single
//! rebuild. The inner per-batch logic is exposed via [`handle_event_batch`]
//! for direct unit testing.

use std::path::Path;
use std::time::Duration;

use anyhow::{Context, Result};
use notify::{EventKind, RecursiveMode};
use notify_debouncer_full::{DebouncedEvent, new_debouncer};
use tracing::{info, warn};

use crate::detect::{CODE_EXTENSIONS, DOC_EXTENSIONS};
use crate::pipeline::{Pipeline, PipelineConfig, PipelineOutputs};

#[cfg(test)]
mod tests;

const DEBOUNCE_MS: u64 = 250;

pub fn watch(cfg: PipelineConfig) -> Result<()> {
    info!(root = %cfg.root.display(), "watching for changes");
    let initial = Pipeline::new(cfg.clone()).run()?;
    info!(
        files = initial.files_scanned,
        cached = initial.files_cached,
        elapsed_ms = initial.elapsed_ms,
        "initial build complete"
    );

    let (tx, rx) = std::sync::mpsc::channel();
    let mut debouncer = new_debouncer(Duration::from_millis(DEBOUNCE_MS), None, tx)
        .context("create file watcher")?;
    debouncer
        .watch(&cfg.root, RecursiveMode::Recursive)
        .context("attach watcher")?;

    // notify reports symlink-resolved absolute paths (e.g. `/private/var/...`
    // on macOS). Pre-canonicalize the output dir so prefix checks line up.
    let out_dir = cfg
        .out_root
        .join("graphy-out")
        .canonicalize()
        .unwrap_or_else(|_| cfg.out_root.join("graphy-out"));

    while let Ok(events) = rx.recv() {
        let events = events.map_err(|errs| anyhow::anyhow!("watch error: {errs:?}"))?;
        handle_event_batch(&cfg, &out_dir, &events);
    }
    Ok(())
}

/// Process one debounced batch of events: skip if no relevant change, else
/// re-run the pipeline and log the outcome. Returns the rebuild result so
/// callers (and tests) can inspect it.
pub fn handle_event_batch(
    cfg: &PipelineConfig,
    out_dir: &Path,
    events: &[DebouncedEvent],
) -> Option<Result<PipelineOutputs>> {
    if !events_warrant_rebuild(events, out_dir) {
        return None;
    }
    let result = Pipeline::new(cfg.clone()).run();
    match &result {
        Ok(r) => info!(
            files = r.files_scanned,
            cached = r.files_cached,
            elapsed_ms = r.elapsed_ms,
            nodes = r.analysis.node_count,
            edges = r.analysis.edge_count,
            "rebuild"
        ),
        Err(e) => warn!(error = %e, "rebuild failed"),
    }
    Some(result)
}

pub(crate) fn events_warrant_rebuild(events: &[DebouncedEvent], out_dir: &Path) -> bool {
    for ev in events {
        if !matches!(
            ev.event.kind,
            EventKind::Create(_) | EventKind::Modify(_) | EventKind::Remove(_)
        ) {
            continue;
        }
        for path in &ev.event.paths {
            // Ignore changes inside our own output dir to avoid feedback loops.
            if path.starts_with(out_dir) {
                continue;
            }
            let ext = path
                .extension()
                .and_then(|s| s.to_str())
                .map(|s| s.to_ascii_lowercase())
                .unwrap_or_default();
            if CODE_EXTENSIONS.contains(ext.as_str()) || DOC_EXTENSIONS.contains(ext.as_str()) {
                return true;
            }
        }
    }
    false
}
