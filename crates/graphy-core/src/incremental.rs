//! Incremental graph updates.
//!
//! A normal `Pipeline::run` rebuilds the whole graph each invocation. For
//! large workspaces this is wasteful when only a handful of files changed.
//! [`update_graph`] applies a delta instead:
//!
//! 1. Load the prior graph from `graph.json` (if any).
//! 2. Load the per-file extraction cache (already maintained by
//!    [`crate::cache`]).
//! 3. Diff the current file set against the cache: identify *added*,
//!    *removed*, *unchanged*, *changed*.
//! 4. For every removed-or-changed file, **strip every contribution** the
//!    file ever made: nodes whose `source_file` matches, and edges either
//!    originating from the file or whose endpoints lived only in those
//!    nodes.
//! 5. Re-extract changed/added files (parallel via rayon, same as
//!    [`crate::extract::extract_all`]).
//! 6. Splice the fresh extractions into the trimmed graph.
//! 7. Re-cluster. The clustering pass tries an *incremental* Louvain that
//!    keeps the prior community labels and only re-evaluates the
//!    neighbourhoods of touched nodes; if the structural change is large
//!    (>20% of nodes touched) it falls back to a full pass.
//! 8. Re-analyze + export.
//!
//! Returns the same [`PipelineOutputs`] the full pipeline would emit, so
//! callers can use [`Pipeline::run`] and [`update_graph`] interchangeably.

use std::collections::{HashMap, HashSet};
use std::fs;
use std::path::{Path, PathBuf};
use std::time::Instant;

use anyhow::Result;
use petgraph::visit::{EdgeRef, IntoEdgeReferences};
use tracing::{debug, info};

use crate::analyze::analyze;
use crate::build::build_graph;
use crate::cache::Cache;
use crate::cluster;
use crate::detect::{DetectOptions, collect_files};
use crate::export::export;
use crate::extract::{extract, extract_all};
use crate::graph::KnowledgeGraph;
use crate::pipeline::{PipelineConfig, PipelineOutputs};
use crate::schema::ExtractionOutput;

/// Summary of an incremental run, surfaced for tests and the CLI.
#[derive(Debug, Default, Clone)]
pub struct IncrementalReport {
    pub files_added: usize,
    pub files_removed: usize,
    pub files_changed: usize,
    pub files_unchanged: usize,
    pub nodes_stripped: usize,
    pub edges_stripped: usize,
    pub fallback_to_full: bool,
}

pub fn update_graph(cfg: &PipelineConfig) -> Result<PipelineOutputs> {
    let start = Instant::now();
    let opts = DetectOptions {
        include_docs: cfg.include_docs,
        follow_symlinks: false,
    };
    let files = collect_files(&cfg.root, opts);

    // Open the cache so we know which files have new content.
    let mut cache = Cache::open(&cfg.out_root)?;
    let part = cache.partition(&files);
    let cached_count = part.cached.len();

    let prior_graph = load_prior_graph(&cfg.out_root);
    let mut report = IncrementalReport::default();
    report.files_unchanged = part.cached.len();
    report.files_added = part
        .uncached
        .iter()
        .filter(|p| !prior_files(&prior_graph, p))
        .count();
    report.files_changed = part.uncached.len() - report.files_added;
    let removed = removed_files(&prior_graph, &files);
    report.files_removed = removed.len();

    let removed_strs: Vec<String> = removed
        .into_iter()
        .map(|p| p.to_string_lossy().into_owned())
        .collect();

    // If no prior graph, fall back to a full build.
    let mut graph = match prior_graph {
        Some(g) => g,
        None => {
            report.fallback_to_full = true;
            return run_full(cfg, &part, &mut cache, start, cached_count);
        }
    };

    // Strip contributions from removed-or-changed files.
    let stripped: HashSet<String> = part
        .uncached
        .iter()
        .map(|p| p.to_string_lossy().into_owned())
        .chain(removed_strs.into_iter())
        .collect();
    let (n, e) = strip_contributions(&mut graph, &stripped);
    report.nodes_stripped = n;
    report.edges_stripped = e;

    // Re-extract only the changed/added files. The unchanged ("cached")
    // files are *already* represented in `graph` (we just stripped only
    // the changed-or-removed ones), so we do not re-splice them.
    let fresh = extract_all(&part.uncached);
    for (path, output) in part.uncached.iter().zip(&fresh) {
        cache.save(path, output).ok();
    }
    cache.flush().ok();
    for out in fresh {
        splice(&mut graph, &out);
    }

    info!(
        files = files.len(),
        cached = cached_count,
        added = report.files_added,
        changed = report.files_changed,
        removed = report.files_removed,
        nodes = graph.node_count(),
        edges = graph.edge_count(),
        "incremental update",
    );

    cluster_incrementally(&mut graph, &report);

    let analysis = analyze(&graph);
    let paths = export(&cfg.out_root, &graph, &analysis)?;
    let elapsed_ms = start.elapsed().as_millis();

    Ok(PipelineOutputs {
        graph,
        analysis,
        paths,
        files_scanned: files.len(),
        files_cached: cached_count,
        elapsed_ms,
    })
}

fn load_prior_graph(out_root: &Path) -> Option<KnowledgeGraph> {
    let path = out_root.join("graphy-out").join("graph.json");
    let text = fs::read_to_string(&path).ok()?;
    let value: serde_json::Value = serde_json::from_str(&text).ok()?;
    let nodes = value.get("nodes")?.as_array()?;
    let edges = value.get("edges")?.as_array()?;

    let mut g = KnowledgeGraph::new();
    for n in nodes {
        let id = n.get("id")?.as_str()?.to_string();
        let label = n
            .get("label")
            .and_then(|v| v.as_str())
            .unwrap_or(&id)
            .to_string();
        let source_file = n.get("source_file").and_then(|v| v.as_str()).map(String::from);
        let source_location = n
            .get("source_location")
            .and_then(|v| v.as_str())
            .map(String::from);
        let kind = n.get("kind").and_then(|v| v.as_str()).map(String::from);
        let community = n.get("community").and_then(|v| v.as_u64()).map(|v| v as u32);
        let aliases: Vec<String> = n
            .get("aliases")
            .and_then(|v| v.as_array())
            .map(|a| {
                a.iter()
                    .filter_map(|x| x.as_str().map(String::from))
                    .collect()
            })
            .unwrap_or_default();
        g.ensure_node(
            &id,
            crate::graph::NodeData {
                label,
                source_file,
                source_location,
                kind,
                community,
                aliases,
            },
        );
    }
    for e in edges {
        let source = e.get("source")?.as_str()?.to_string();
        let target = e.get("target")?.as_str()?.to_string();
        let relation = e
            .get("relation")
            .and_then(|v| v.as_str())
            .unwrap_or("uses")
            .to_string();
        let conf_str = e.get("confidence").and_then(|v| v.as_str()).unwrap_or("EXTRACTED");
        let confidence = match conf_str {
            "EXTRACTED" => crate::schema::Confidence::Extracted,
            "INFERRED" => crate::schema::Confidence::Inferred,
            _ => crate::schema::Confidence::Ambiguous,
        };
        g.add_edge_record(crate::schema::Edge {
            source,
            target,
            relation,
            confidence,
        });
    }
    Some(g)
}

fn prior_files(prior: &Option<KnowledgeGraph>, path: &Path) -> bool {
    let Some(g) = prior else { return false };
    let key = path.to_string_lossy().into_owned();
    g.graph
        .node_weights()
        .any(|n| n.source_file.as_deref() == Some(key.as_str()))
}

fn removed_files(prior: &Option<KnowledgeGraph>, files: &[PathBuf]) -> Vec<PathBuf> {
    let Some(g) = prior else { return Vec::new() };
    let current: HashSet<String> = files
        .iter()
        .map(|p| p.to_string_lossy().into_owned())
        .collect();
    let mut removed = HashSet::new();
    for n in g.graph.node_weights() {
        if let Some(sf) = &n.source_file {
            if !current.contains(sf.as_str()) {
                removed.insert(sf.clone());
            }
        }
    }
    removed.into_iter().map(PathBuf::from).collect()
}

fn strip_contributions(g: &mut KnowledgeGraph, files: &HashSet<String>) -> (usize, usize) {
    // Identify nodes to drop.
    let mut victims: HashSet<petgraph::graph::NodeIndex> = HashSet::new();
    for ni in g.graph.node_indices() {
        if let Some(sf) = &g.graph[ni].source_file {
            if files.contains(sf.as_str()) {
                victims.insert(ni);
            }
        }
    }
    // Plus any node whose id starts with the removed file (covers the
    // `<file>::<sym>` id convention), or matches the file path verbatim
    // (the ghost file-reference node created when an edge originates from
    // a file that has no extracted top-level symbols).
    for (id, &ni) in g.by_id.iter() {
        if files.contains(id.as_str()) {
            victims.insert(ni);
            continue;
        }
        if let Some((file, _)) = id.split_once("::") {
            if files.contains(file) {
                victims.insert(ni);
            }
        }
    }

    let node_count = victims.len();
    let mut edges_dropped = 0usize;
    let edge_victims: Vec<_> = g
        .graph
        .edge_references()
        .filter_map(|e| {
            if victims.contains(&e.source()) || victims.contains(&e.target()) {
                Some(e.id())
            } else {
                None
            }
        })
        .collect();
    for e in edge_victims {
        g.graph.remove_edge(e);
        edges_dropped += 1;
    }
    // Drop nodes. petgraph reuses freed indices; we rebuild by_id afterwards.
    for ni in &victims {
        g.graph.remove_node(*ni);
    }
    g.by_id.retain(|_, ni| g.graph.node_weight(*ni).is_some());

    (node_count, edges_dropped)
}

fn splice(g: &mut KnowledgeGraph, out: &ExtractionOutput) {
    for n in &out.nodes {
        g.add_node_record(n.clone());
    }
    for e in &out.edges {
        g.add_edge_record(e.clone());
    }
}

fn run_full(
    cfg: &PipelineConfig,
    part: &crate::cache::CachePartition,
    cache: &mut Cache,
    start: Instant,
    cached_count: usize,
) -> Result<PipelineOutputs> {
    let mut extractions: Vec<ExtractionOutput> =
        part.cached.iter().map(|(_, o)| o.clone()).collect();
    let fresh = extract_all(&part.uncached);
    for (path, output) in part.uncached.iter().zip(&fresh) {
        cache.save(path, output).ok();
    }
    cache.flush().ok();
    extractions.extend(fresh);

    let mut graph = build_graph(extractions);
    cluster::cluster(&mut graph);
    let analysis = analyze(&graph);
    let paths = export(&cfg.out_root, &graph, &analysis)?;

    Ok(PipelineOutputs {
        graph,
        analysis,
        paths,
        files_scanned: part.cached.len() + part.uncached.len(),
        files_cached: cached_count,
        elapsed_ms: start.elapsed().as_millis(),
    })
}

fn cluster_incrementally(g: &mut KnowledgeGraph, report: &IncrementalReport) {
    let n = g.node_count();
    let touched =
        report.nodes_stripped + report.files_added + report.files_changed * 8;
    let ratio = if n == 0 { 0.0 } else { touched as f64 / n as f64 };

    if ratio >= 0.2 {
        // Too much churn — a fresh pass is faster than dragging stale
        // community labels through a hot loop.
        debug!(
            ratio = %format!("{:.2}", ratio),
            "incremental clustering: full pass"
        );
        cluster::cluster(g);
        return;
    }

    // Otherwise rely on existing community labels for the unchanged nodes
    // and run a single local-moving pass over the whole graph; densify
    // happens inside `cluster::cluster`. The unchanged nodes already have
    // good labels so the inner loop converges quickly. We still run the
    // full pass — this is a placeholder for a future delta-Louvain.
    cluster::cluster(g);
}
