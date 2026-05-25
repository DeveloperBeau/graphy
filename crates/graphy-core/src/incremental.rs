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
    let mut part = cache.partition(&files);
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

    // Cross-file edges that pointed at stripped nodes were forcibly
    // removed by petgraph along with their endpoints. To make sure every
    // edge in the final graph is rooted in a current extraction, drop
    // every surviving edge and re-splice from both fresh and cached
    // extractions below. Nodes already in the prior graph survive — they
    // dedupe by id when re-spliced.
    let surviving_edges: Vec<_> = graph.graph.edge_indices().collect();
    for e in surviving_edges {
        graph.graph.remove_edge(e);
    }

    let fresh = extract_all(&part.uncached);
    for (path, output) in part.uncached.iter().zip(&fresh) {
        cache.save(path, output).ok();
    }
    cache.flush().ok();

    // Apply any persisted dedup decisions from prior runs so the cached
    // extractions splice in canonical form. Eliminates a re-dedup pass on
    // warm runs.
    //
    // IMPORTANT: we build a *merged* redirect map from ALL cached files before
    // applying. The same extern id (e.g. `extern::fmt`) can be emitted by
    // multiple files; dedup resolves it once and attributes the redirect only
    // to the file whose node was iterated first. All other files that emit the
    // same extern still carry it in their raw extractions, so we must apply the
    // redirect from ANY file's map to EVERY extraction — not just the map that
    // happens to belong to that specific file.
    // Build two structures used both for apply and for write-back fanout:
    //
    // 1. `merged`: union of all redirects/ambiguous marks from all per-file
    //    maps written during the previous run. Using the union ensures that an
    //    extern id which appears in N files is removed from ALL of them, not
    //    just the one file whose map happened to record the resolution.
    //
    // 2. `file_extern_ids`: for each cached file, the set of `extern::*` node
    //    ids present in its raw extraction (before apply). Needed at write-back
    //    time to fan out new dedup redirects to every file that contributes a
    //    given extern, not just the one that "won" the splice-time dedup.
    let mut merged = crate::dedup::map::DedupMap::empty_for("");
    // Maps file path → set of extern ids in its raw extraction.
    let mut file_extern_ids: HashMap<PathBuf, HashSet<String>> = HashMap::new();
    if cfg.dedup {
        for (path, out) in part.cached.iter() {
            // Record the raw extern ids for this file.
            let extern_ids: HashSet<String> = out
                .nodes
                .iter()
                .filter(|n| n.id.starts_with("extern::"))
                .map(|n| n.id.clone())
                .collect();
            if !extern_ids.is_empty() {
                file_extern_ids.insert(path.clone(), extern_ids);
            }
            // Merge this file's prior dedup map into `merged`.
            if let Some(map) = cache.load_dedup_map(path) {
                for r in map.redirects.iter() {
                    if !merged.redirects.iter().any(|x| x.from == r.from) {
                        merged.redirects.push(r.clone());
                    }
                }
                for a in map.ambiguous_marked.iter() {
                    if !merged.ambiguous_marked.contains(a) {
                        merged.ambiguous_marked.push(a.clone());
                    }
                }
            }
        }
        // Apply the merged map to every cached extraction so externs that were
        // resolved in any prior run are removed before the graph is spliced.
        for (_, out) in part.cached.iter_mut() {
            crate::dedup::map::apply_dedup_map(out, &merged);
        }
    }

    // Splice cached extractions first (nodes dedupe; edges accumulate).
    for (_, out) in &part.cached {
        splice(&mut graph, out);
    }
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

    // Dedup BEFORE clustering: freshly spliced extern nodes need to be
    // collapsed into their canonical defs before we count communities,
    // otherwise the delta-Louvain seed sees them as fresh dirty nodes
    // and assigns them their own communities — inflating the count.
    let mut dedup_imports_resolved = 0usize;
    if cfg.dedup {
        let dr = crate::dedup::dedup(&mut graph);
        dedup_imports_resolved = dr.imports_resolved;
        info!(
            imports = dr.imports_resolved,
            merged = dr.reexports_merged,
            ambiguous = dr.ambiguous_groups,
            "dedup pass (incremental)"
        );
        // Build the write-back maps: start from the existing (prior) per-file
        // maps so previously-applied redirects are preserved, then add any
        // newly-resolved redirects. Finally, fan each new redirect out to every
        // cached file whose raw extraction contained the same `extern::X` id —
        // not just the file whose node happened to survive the splice-time dedup.
        //
        // Seeding from the prior maps is critical: without it, a warm run would
        // overwrite the maps with only the newly-resolved externs, discarding
        // the redirects that were correctly applied (and thus not re-resolved).
        let all_redirects_union: Vec<crate::dedup::map::Redirect> = {
            let mut union: Vec<crate::dedup::map::Redirect> = merged.redirects.clone();
            for (_, map) in &dr.per_file_maps {
                for r in &map.redirects {
                    if !union.iter().any(|x| x.from == r.from) {
                        union.push(r.clone());
                    }
                }
            }
            union
        };
        // For each cached file, write back all redirects that touch an extern
        // present in that file's raw extraction.
        let mut written: HashSet<String> = HashSet::new();
        for (path, extern_ids) in &file_extern_ids {
            let key = path.to_string_lossy().into_owned();
            let applicable: Vec<crate::dedup::map::Redirect> = all_redirects_union
                .iter()
                .filter(|r| extern_ids.contains(&r.from))
                .cloned()
                .collect();
            if !applicable.is_empty() {
                let map = crate::dedup::map::DedupMap {
                    version: crate::dedup::map::SCHEMA_VERSION,
                    for_extraction: String::new(),
                    redirects: applicable,
                    ambiguous_marked: Vec::new(),
                };
                let _ = cache.save_dedup_map(path, &map);
                written.insert(key);
            }
        }
        // For files that had a dedup map entry (even empty) but no externs,
        // preserve whatever dr.per_file_maps says (e.g. ambiguous_marked).
        for (file_key, map) in &dr.per_file_maps {
            if !written.contains(file_key) {
                let p = std::path::PathBuf::from(file_key);
                let _ = cache.save_dedup_map(&p, map);
            }
        }
        // Ensure every changed/added file gets a .dedup.json even if dedup
        // found nothing to do for it (empty map).  This keeps the cache
        // consistent: a missing .dedup.json at the current hash means the
        // file has never been through a dedup pass.
        for file in &part.uncached {
            let key = file.to_string_lossy().into_owned();
            if !written.contains(&key) && !dr.per_file_maps.contains_key(&key) {
                let _ = cache.save_dedup_map(
                    file,
                    &crate::dedup::map::DedupMap::empty_for(""),
                );
            }
        }
        cache.flush().ok();
    }

    cluster_incrementally(&mut graph, &report);

    let mut analysis = analyze(&graph);
    analysis.dedup_imports_resolved = dedup_imports_resolved;
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
    // Identify the nodes that need re-evaluation: every node whose source
    // file is a freshly extracted file. Their community labels are blank
    // after the splice; their neighbours may need to follow.
    let n = g.node_count();
    if n == 0 {
        return;
    }
    let dirty: Vec<petgraph::graph::NodeIndex> = g
        .graph
        .node_indices()
        .filter(|ni| g.graph[*ni].community.is_none())
        .collect();
    debug!(
        dirty = dirty.len(),
        total = n,
        ratio = %format!("{:.2}", dirty.len() as f64 / n as f64),
        "delta-louvain candidate set"
    );

    if dirty.is_empty() && report.files_removed == 0 {
        // Nothing changed structurally; prior labels are still valid.
        return;
    }
    cluster::cluster_seeded(g, &dirty);
}
