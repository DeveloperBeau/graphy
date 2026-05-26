//! Orchestrator: detect → extract → build → cluster → analyze → report → export.

use std::path::{Path, PathBuf};
use std::time::Instant;

use anyhow::Result;
use tracing::info;

use crate::analyze::{Analysis, analyze};
use crate::build::build_graph;
use crate::cache::Cache;
use crate::cluster::{cluster_with_recorder, levels as cluster_levels};
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
    /// When true, build/load/patch the SCC index and pass it to
    /// delta-Louvain for cycle-aware community assignment. Defaults to true.
    pub scc_expansion: bool,
    /// When true (default), persist + reuse Louvain level state across runs.
    pub hierarchical_clustering: bool,
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
            scc_expansion: true,
            hierarchical_clustering: true,
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

        // Hoist cache so it stays alive through the dedup pass (we need it to
        // persist per-file maps after dedup).
        let mut cache = if self.cfg.use_cache {
            Some(Cache::open(&self.cfg.out_root)?)
        } else {
            None
        };

        let (mut extractions, files_cached) = if let Some(ref mut cache) = cache {
            let part = cache.partition(&files);
            let cached_count = part.cached.len();
            let mut all: Vec<(PathBuf, _)> = part.cached;
            let fresh = extract_all(&part.uncached);
            for (path, output) in part.uncached.iter().zip(&fresh) {
                let _ = cache.save(path, output);
            }
            cache.flush().ok();
            all.extend(part.uncached.into_iter().zip(fresh));
            (all, cached_count)
        } else {
            let outputs = extract_all(&files);
            let paired: Vec<(PathBuf, _)> = files.iter().cloned().zip(outputs).collect();
            (paired, 0)
        };

        // Build a file → extern-ids index before consuming the extractions.
        // This is used after dedup to fan-out each resolved redirect to EVERY
        // file that emits the same extern id, not just the one that "won" the
        // splice-time node dedup.
        let file_extern_ids: std::collections::HashMap<String, std::collections::HashSet<String>> =
            extractions
                .iter()
                .map(|(path, out)| {
                    let key = path.to_string_lossy().into_owned();
                    let ids: std::collections::HashSet<String> = out
                        .nodes
                        .iter()
                        .filter(|n| n.id.starts_with("extern::"))
                        .map(|n| n.id.clone())
                        .collect();
                    (key, ids)
                })
                .filter(|(_, ids)| !ids.is_empty())
                .collect();

        let extractions: Vec<_> = extractions.into_iter().map(|(_, o)| o).collect();
        let mut graph = build_graph(extractions);
        let mut dedup_imports_resolved = 0usize;
        let mut dedup_glob_imports_skipped = 0usize;
        if self.cfg.dedup {
            let report = crate::dedup::dedup(&mut graph);
            dedup_imports_resolved = report.imports_resolved;
            dedup_glob_imports_skipped = report.glob_imports_skipped;
            info!(
                imports = report.imports_resolved,
                merged = report.reexports_merged,
                ambiguous = report.ambiguous_groups,
                globs = report.glob_imports_skipped,
                "dedup pass"
            );
            if let Some(ref mut cache) = cache {
                // Fan out each redirect to every file that contributed the
                // same `extern::X` node, not just the attributed source file.
                let mut augmented = report.per_file_maps.clone();
                for (file_key, extern_ids) in &file_extern_ids {
                    for (_, map) in &report.per_file_maps {
                        for r in &map.redirects {
                            if extern_ids.contains(&r.from) {
                                let entry = augmented
                                    .entry(file_key.clone())
                                    .or_insert_with(|| crate::dedup::map::DedupMap::empty_for(""));
                                if !entry.redirects.iter().any(|x| x.from == r.from) {
                                    entry.redirects.push(r.clone());
                                }
                            }
                        }
                    }
                }
                // Write populated maps first, then write an empty map for
                // every file that dedup didn't touch.  This ensures every
                // file always has a .dedup.json keyed to its current content
                // hash, which lets the invalidation logic detect stale maps.
                for (file_key, map) in &augmented {
                    let p = std::path::PathBuf::from(file_key);
                    let _ = cache.save_dedup_map(&p, map);
                }
                for file in &files {
                    let key = file.to_string_lossy().into_owned();
                    if !augmented.contains_key(&key) {
                        let _ = cache.save_dedup_map(
                            file,
                            &crate::dedup::map::DedupMap::empty_for(""),
                        );
                    }
                }
                cache.flush().ok();
            }
        }
        let nodes = graph.node_count();
        let edges = graph.edge_count();
        info!(nodes, edges, "graph built");

        if self.cfg.hierarchical_clustering {
            let mut rec = cluster_levels::LevelRecorder::new();
            cluster_with_recorder(&mut graph, &mut rec);
            let levels_path = self
                .cfg
                .out_root
                .join("graphy-out")
                .join(".cache")
                .join("louvain-levels.json");
            let store = cluster_levels::LouvainLevels {
                version: cluster_levels::SCHEMA_VERSION,
                graph_hash: cluster_levels::graph_hash_of(&graph),
                modularity: cluster_levels::compute_modularity(&graph),
                levels: rec.into_levels(),
            };
            let _ = store.save(&levels_path);
        } else {
            crate::cluster::cluster(&mut graph);
        }
        // Full rebuild invalidates any prior incremental SCC index; delete it
        // so the next incremental run rebuilds from the canonical graph.
        let scc_path = self
            .cfg
            .out_root
            .join("graphy-out")
            .join(".cache")
            .join("scc.json");
        let _ = std::fs::remove_file(&scc_path);
        let mut analysis = analyze(&graph);
        analysis.dedup_imports_resolved = dedup_imports_resolved;
        analysis.glob_imports_skipped = dedup_glob_imports_skipped;
        analysis.modularity = crate::cluster::modularity(&graph);
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
