//! Orchestrator: detect → extract → build → cluster → analyze → report → export.

use std::path::{Path, PathBuf};
use std::time::Instant;

use anyhow::Result;
use tracing::info;

use crate::analyze::{Analysis, analyze};
use crate::build::build_graph;
use crate::cache::Cache;
use crate::cluster::cluster;
use crate::detect::{DetectOptions, collect_files};
use crate::export::{ExportPaths, export};
use crate::extract::extract_all;
use crate::graph::KnowledgeGraph;

#[derive(Debug, Clone)]
pub struct PipelineConfig {
    pub root: PathBuf,
    pub out_root: PathBuf,
    pub include_docs: bool,
    /// When true, skip extraction for files whose content hash matches the
    /// cached output. Defaults to true.
    pub use_cache: bool,
    /// When true, run entity deduplication after the graph is built.
    /// Defaults to true.
    pub dedup: bool,
    /// When true and a prior `graph.json` is on disk, apply only a delta
    /// rather than rebuilding from scratch. Falls back to a full build on
    /// the first run automatically. Defaults to true.
    pub incremental: bool,
}

impl PipelineConfig {
    pub fn new(root: impl Into<PathBuf>) -> Self {
        let root = root.into();
        Self {
            out_root: root.clone(),
            root,
            include_docs: false,
            use_cache: true,
            dedup: true,
            incremental: true,
        }
    }
}

pub struct PipelineOutputs {
    pub graph: KnowledgeGraph,
    pub analysis: Analysis,
    pub paths: ExportPaths,
    pub files_scanned: usize,
    pub files_cached: usize,
    pub elapsed_ms: u128,
}

pub struct Pipeline {
    cfg: PipelineConfig,
}

impl Pipeline {
    pub fn new(cfg: PipelineConfig) -> Self {
        Self { cfg }
    }

    pub fn run(&self) -> Result<PipelineOutputs> {
        // Incremental fast-path: if a prior graph is on disk and the user
        // has not opted out, apply a delta instead of rebuilding from
        // scratch. `update_graph` falls through to a full build itself
        // when there is no prior graph.
        if self.cfg.incremental {
            let prior_exists = self
                .cfg
                .out_root
                .join("graphy-out")
                .join("graph.json")
                .exists();
            if prior_exists {
                // `update_graph` runs dedup itself (when cfg.dedup is on)
                // so that clustering operates on the canonical graph.
                return crate::incremental::update_graph(&self.cfg);
            }
        }

        let start = Instant::now();
        let files = collect_files(
            &self.cfg.root,
            DetectOptions {
                include_docs: self.cfg.include_docs,
                follow_symlinks: false,
            },
        );
        info!(count = files.len(), "files detected");

        let (mut extractions, files_cached) = if self.cfg.use_cache {
            let mut cache = Cache::open(&self.cfg.out_root)?;
            let part = cache.partition(&files);
            let cached_count = part.cached.len();
            let mut all: Vec<_> = part.cached.into_iter().map(|(_, o)| o).collect();
            let fresh = extract_all(&part.uncached);
            for (path, output) in part.uncached.iter().zip(&fresh) {
                let _ = cache.save(path, output);
            }
            cache.flush().ok();
            all.extend(fresh);
            (all, cached_count)
        } else {
            (extract_all(&files), 0)
        };
        let extractions = std::mem::take(&mut extractions);

        let mut graph = build_graph(extractions);
        if self.cfg.dedup {
            let report = crate::dedup::dedup(&mut graph);
            info!(
                imports = report.imports_resolved,
                merged = report.reexports_merged,
                ambiguous = report.ambiguous_groups,
                "dedup pass"
            );
        }
        let nodes = graph.node_count();
        let edges = graph.edge_count();
        info!(nodes, edges, "graph built");

        cluster(&mut graph);
        let analysis = analyze(&graph);
        let paths = export(&self.cfg.out_root, &graph, &analysis)?;

        Ok(PipelineOutputs {
            graph,
            analysis,
            paths,
            files_scanned: files.len(),
            files_cached,
            elapsed_ms: start.elapsed().as_millis(),
        })
    }
}

/// Convenience: run with defaults under `root`.
pub fn run(root: &Path) -> Result<PipelineOutputs> {
    Pipeline::new(PipelineConfig::new(root)).run()
}
