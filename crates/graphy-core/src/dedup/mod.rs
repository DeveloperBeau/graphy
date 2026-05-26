//! Entity deduplication.
//!
//! Two passes:
//!
//! 1. **Import resolution.** An `extern::<target>` node whose trailing
//!    leaf-name matches a defined symbol in the graph is collapsed into
//!    that definition. The `imports` edge that originally pointed at the
//!    extern is redirected at the definition. The extern's original id
//!    is preserved on the surviving node as an entry in `aliases`.
//!
//! 2. **Re-export / alias collapse.** Two definition nodes that share the
//!    same `(label, kind)` and have at least one connecting `imports`
//!    edge (one re-exports the other) are merged. The node with the
//!    higher in-degree wins; the loser becomes an alias.
//!
//! Same-label same-kind nodes that have *no* connecting edge are flagged
//! as **ambiguous** rather than merged — they might genuinely be distinct
//! symbols that happen to share a name. The flag is written to the
//! node's `kind` suffix as `<kind>?ambiguous` and surfaced in the report.
//!
//! Confidence on redirected edges is downgraded from `EXTRACTED` to
//! `INFERRED` (the link was originally explicit but the resolution to
//! a local symbol is a heuristic).

pub mod map;

use std::collections::{HashMap, HashSet};

use petgraph::graph::NodeIndex;

use crate::dedup::map::{DedupMap, Redirect};
use crate::graph::{KnowledgeGraph, NodeData};
use crate::schema::Confidence;

/// Summary of what `dedup` collapsed; surfaced via the [`Analysis`] block
/// so reports can show the impact.
///
/// [`Analysis`]: crate::analyze::Analysis
#[derive(Debug, Default, Clone, serde::Serialize, serde::Deserialize)]
pub struct DedupReport {
    pub imports_resolved: usize,
    pub reexports_merged: usize,
    pub ambiguous_groups: usize,
    /// Number of simple extern nodes created by splitting legacy compound
    /// `extern::<prefix>::{a, b, c}` nodes that were persisted by older
    /// graph versions. Tracked separately from `imports_resolved` because
    /// splits are node creations, not import-to-definition redirects.
    pub compound_externs_split: usize,
    /// Number of `extern::*` glob nodes (e.g. `use a::*`, `from a import *`)
    /// that resolution skipped because they are unresolvable without scope
    /// analysis. Glob nodes remain on the graph.
    #[serde(default)]
    pub glob_imports_skipped: usize,
    pub per_file_maps: HashMap<String, DedupMap>,
}

/// Collapse externs that resolve to local definitions, merge re-exports,
/// flag ambiguous duplicates. Returns counters for the report.
pub fn dedup(g: &mut KnowledgeGraph) -> DedupReport {
    let split = pre_split_compound_externs(g);
    let mut per_file_maps: HashMap<String, DedupMap> = HashMap::new();
    let mut report = DedupReport::default();
    let (resolved, glob_skipped) = resolve_imports(g, &mut per_file_maps);
    report.imports_resolved = resolved;
    report.glob_imports_skipped = glob_skipped;
    let (merged, ambiguous) = collapse_aliases(g, &mut per_file_maps);
    // `split` counts new node creations, not import-to-definition redirects.
    // Store it in its own field so callers can distinguish the two.
    report.compound_externs_split = split;
    report.reexports_merged = merged;
    report.ambiguous_groups = ambiguous;
    report.per_file_maps = per_file_maps;
    report
}

fn ensure_map<'a>(maps: &'a mut HashMap<String, DedupMap>, file: &str) -> &'a mut DedupMap {
    maps.entry(file.to_string())
        .or_insert_with(|| DedupMap::empty_for(""))
}

// ---------- pass 1: extern imports -> local defs ----------

fn resolve_imports(g: &mut KnowledgeGraph, per_file_maps: &mut HashMap<String, DedupMap>) -> (usize, usize) {
    // Build a multi-key index: every non-extern node is registered under
    // each progressive suffix of its qualified path. For a node `helper`
    // in `src/foo/bar.rs` the keys are: `helper`, `bar::helper`,
    // `foo::bar::helper`, `src::foo::bar::helper`. Resolution prefers the
    // longest matching suffix to disambiguate same-leaf collisions.
    let mut suffix_index: HashMap<String, Vec<NodeIndex>> = HashMap::new();
    let extern_ids: HashSet<String> = g
        .by_id
        .iter()
        .filter(|(id, _)| id.starts_with("extern::"))
        .map(|(id, _)| id.clone())
        .collect();

    for (id, &idx) in g.by_id.iter() {
        if id.starts_with("extern::") {
            continue;
        }
        for key in qualified_suffixes(&g.graph[idx]) {
            suffix_index.entry(key).or_default().push(idx);
        }
    }

    let mut redirects: Vec<(NodeIndex, NodeIndex, String, Option<String>)> = Vec::new();
    let mut glob_skipped = 0usize;
    for extern_id in &extern_ids {
        let Some(&extern_idx) = g.by_id.get(extern_id) else { continue };
        let label = g.graph[extern_idx].label.clone();
        if crate::extract::common::is_glob(&label) {
            glob_skipped += 1;
            continue;
        }
        let source_file = g.graph[extern_idx].source_file.clone();
        let Some(target) = best_match(&suffix_index, &label) else { continue };
        if target == extern_idx {
            continue;
        }
        redirects.push((extern_idx, target, extern_id.clone(), source_file));
    }

    let count = redirects.len();
    for (from, to, original_id, source_file) in redirects {
        // Capture target id before redirect_node invalidates indices.
        let target_id = id_of(g, to);
        redirect_node(g, from, to, &original_id);
        // Record the redirect in per_file_maps if we know the source file.
        if let Some(file) = source_file {
            let map = ensure_map(per_file_maps, &file);
            map.redirects.push(Redirect {
                from: original_id,
                to: target_id,
                edge_relation: None,
                confidence_downgrade: true,
            });
        }
    }
    (count, glob_skipped)
}

/// Every progressive suffix of a node's qualified path. Path components
/// come from the file path (parents → file stem), label is appended last.
fn qualified_suffixes(data: &NodeData) -> Vec<String> {
    let mut out = vec![data.label.clone()];
    let Some(file) = data.source_file.as_deref() else { return out };
    let stem = std::path::Path::new(file);
    let mut parts: Vec<String> = stem
        .components()
        .filter_map(|c| c.as_os_str().to_str().map(String::from))
        .collect();
    if let Some(last) = parts.last_mut() {
        if let Some(dot) = last.rfind('.') {
            last.truncate(dot);
        }
    }
    // Drop leading "/" or drive-letter components — they're not part of a
    // logical qualified path.
    parts.retain(|p| !p.is_empty() && p != "/");
    for k in 1..=parts.len() {
        let slice = &parts[parts.len() - k..];
        let mut joined = slice.join("::");
        joined.push_str("::");
        joined.push_str(&data.label);
        out.push(joined);
    }
    out
}

/// Best (longest-suffix-first) unique match for an extern label.
///
/// `extern_label` looks like `crate::a::helper`, `std::sync::Arc`, etc.
/// We progressively shorten the right side until a single candidate is
/// found, then return it. Leaf-only matches still work; collisions on
/// leaf are resolved by a longer prefix in the qualified path.
fn best_match(
    index: &HashMap<String, Vec<NodeIndex>>,
    extern_label: &str,
) -> Option<NodeIndex> {
    let cleaned = extern_label
        .trim()
        .trim_start_matches("use ")
        .trim_end_matches(';')
        .trim();
    // Strip an optional ` as <alias>` clause.
    let cleaned = cleaned.split(" as ").next().unwrap_or(cleaned);
    let parts: Vec<&str> = cleaned.split("::").filter(|s| !s.is_empty()).collect();
    if parts.is_empty() {
        return None;
    }
    for k in (1..=parts.len()).rev() {
        let key = parts[parts.len() - k..].join("::");
        if let Some(candidates) = index.get(&key) {
            if candidates.len() == 1 {
                return Some(candidates[0]);
            }
        }
    }
    None
}

// ---------- pass 2: re-export / alias collapse + ambiguity ----------

fn collapse_aliases(g: &mut KnowledgeGraph, per_file_maps: &mut HashMap<String, DedupMap>) -> (usize, usize) {
    let mut groups: HashMap<(String, String), Vec<NodeIndex>> = HashMap::new();
    for ni in g.graph.node_indices() {
        let data = &g.graph[ni];
        let kind = data.kind.clone().unwrap_or_default();
        if kind == "import" || kind.is_empty() {
            continue;
        }
        let key = (data.label.clone(), kind);
        groups.entry(key).or_default().push(ni);
    }

    let mut merged = 0usize;
    let mut ambiguous = 0usize;

    for ((_label, _kind), members) in groups {
        if members.len() < 2 {
            continue;
        }
        if has_connecting_import(&g.graph, &members) {
            let winner = highest_in_degree(&g.graph, &members);
            let winner_id = id_of(g, winner);
            // Collect losers with their source files before any mutations.
            let losers: Vec<(NodeIndex, String, Option<String>)> = members
                .iter()
                .filter(|&&m| m != winner)
                .map(|&m| {
                    let mid = id_of(g, m);
                    let src = g.graph[m].source_file.clone();
                    (m, mid, src)
                })
                .collect();
            for (member, mid, source_file) in losers {
                redirect_node(g, member, winner, &mid);
                if let Some(file) = source_file {
                    let map = ensure_map(per_file_maps, &file);
                    map.redirects.push(Redirect {
                        from: mid,
                        to: winner_id.clone(),
                        edge_relation: None,
                        confidence_downgrade: true,
                    });
                }
                merged += 1;
            }
        } else {
            ambiguous += 1;
            // Collect member ids + source files before mutating.
            let member_info: Vec<(NodeIndex, String, Option<String>)> = members
                .iter()
                .map(|&m| {
                    let mid = id_of(g, m);
                    let src = g.graph[m].source_file.clone();
                    (m, mid, src)
                })
                .collect();
            for (member, mid, source_file) in member_info {
                mark_ambiguous(&mut g.graph[member]);
                if let Some(file) = source_file {
                    let map = ensure_map(per_file_maps, &file);
                    map.ambiguous_marked.push(mid);
                }
            }
        }
    }

    (merged, ambiguous)
}

// ---------- helpers ----------

fn leaf_name(label: &str) -> &str {
    label
        .rsplit(|c: char| matches!(c, ':' | '.' | '>' | '/'))
        .next()
        .unwrap_or(label)
        .trim()
}

fn id_of(g: &KnowledgeGraph, idx: NodeIndex) -> String {
    g.by_id
        .iter()
        .find_map(|(id, &v)| (v == idx).then(|| id.clone()))
        .unwrap_or_default()
}

fn redirect_node(
    g: &mut KnowledgeGraph,
    from: NodeIndex,
    to: NodeIndex,
    original_id: &str,
) {
    // Hoist alias.
    {
        let target = &mut g.graph[to];
        target.aliases.push(original_id.to_string());
    }

    // Rewrite every edge that touches `from` to touch `to`. We have to be
    // careful about the borrow checker — collect first, then mutate.
    let edges: Vec<_> = g
        .graph
        .edge_indices()
        .map(|e| {
            let (s, t) = g.graph.edge_endpoints(e).unwrap();
            (e, s, t)
        })
        .collect();
    for (e, s, t) in edges {
        let new_s = if s == from { to } else { s };
        let new_t = if t == from { to } else { t };
        if new_s == s && new_t == t {
            continue;
        }
        // Skip self-loops created by redirection.
        if new_s == new_t {
            // Preserve edge data, but downgrade to a self-loop alias edge.
            let data = g.graph.edge_weight(e).cloned();
            if let Some(mut d) = data {
                d.confidence = Confidence::Inferred;
                g.graph.add_edge(new_s, new_t, d);
            }
            g.graph.remove_edge(e);
            continue;
        }
        let data = g.graph.edge_weight(e).cloned();
        if let Some(mut d) = data {
            // Resolved/redirected edges are inferences, not raw imports.
            d.confidence = Confidence::Inferred;
            g.graph.add_edge(new_s, new_t, d);
        }
        g.graph.remove_edge(e);
    }

    // Drop the orphan node + its by_id entry. The graph uses StableDiGraph
    // so removing a node does NOT invalidate or shift other NodeIndex values;
    // only the removed node's slot becomes vacant. We therefore only need to
    // remove the single by_id entry for original_id — no full rebuild needed.
    // (The old full-rebuild was the root cause of phantom non-extern ids
    // appearing in by_id: canonical_id_of rewrote `extern::X` entries to
    // `source_file::label`, making them look like non-extern nodes to the
    // suffix index on the next warm run.)
    g.by_id.remove(original_id);
    g.graph.remove_node(from);
}


fn has_connecting_import(
    g: &crate::graph::DiGraph<NodeData, crate::graph::EdgeData>,
    members: &[NodeIndex],
) -> bool {
    let set: HashSet<_> = members.iter().copied().collect();
    for &a in members {
        for nbr in g.neighbors(a) {
            if set.contains(&nbr) {
                // Confirm the edge between them is an import.
                if let Some(e) = g.find_edge(a, nbr) {
                    if g[e].relation == "imports" {
                        return true;
                    }
                }
            }
        }
    }
    false
}

fn highest_in_degree(
    g: &crate::graph::DiGraph<NodeData, crate::graph::EdgeData>,
    members: &[NodeIndex],
) -> NodeIndex {
    let mut best = members[0];
    let mut best_score = g.neighbors_directed(best, petgraph::Direction::Incoming).count();
    for &m in &members[1..] {
        let s = g.neighbors_directed(m, petgraph::Direction::Incoming).count();
        if s > best_score {
            best_score = s;
            best = m;
        }
    }
    best
}

fn mark_ambiguous(data: &mut NodeData) {
    let kind = data.kind.clone().unwrap_or_default();
    if !kind.ends_with("?ambiguous") {
        data.kind = Some(format!("{kind}?ambiguous"));
    }
}

// ---------- pass 0: legacy compound extern splitter ----------

/// Splits any `extern::<prefix>::{a, b, c}` nodes that were persisted by
/// older graph versions (before braced-glob expansion ran at extraction
/// time). Each compound node is replaced by one simple extern per leaf,
/// edges are fanned out to every new node, and the compound id is recorded
/// as an alias so the provenance trail is preserved.
///
/// Returns the number of *new* simple externs that were inserted (may be
/// higher than the number of compound nodes removed when a compound
/// contains many items).
fn pre_split_compound_externs(g: &mut KnowledgeGraph) -> usize {
    use petgraph::visit::EdgeRef;

    let compound_ids: Vec<String> = g
        .by_id
        .keys()
        .filter(|id| id.starts_with("extern::") && id.contains('{'))
        .cloned()
        .collect();

    let mut count = 0;
    for compound_id in compound_ids {
        let Some(&compound_idx) = g.by_id.get(&compound_id) else { continue };
        let label = g.graph[compound_idx].label.clone();
        let source_file = g.graph[compound_idx].source_file.clone();
        let source_location = g.graph[compound_idx].source_location.clone();

        let expanded = crate::extract::common::expand_import_paths(label.as_str());
        if expanded.len() <= 1 {
            continue;
        }

        // Insert a simple extern node for every expanded path.
        let mut new_indices: Vec<petgraph::graph::NodeIndex> =
            Vec::with_capacity(expanded.len());
        for path in &expanded {
            let new_id = format!("extern::{path}");
            let idx = g.ensure_node(
                &new_id,
                NodeData {
                    label: path.clone(),
                    source_file: source_file.clone(),
                    source_location: source_location.clone(),
                    kind: Some("import".into()),
                    community: None,
                    aliases: vec![compound_id.clone()],
                },
            );
            // If the node already existed (ensure_node returned an existing
            // index), its aliases were not updated by ensure_node. We must
            // explicitly append the compound id so provenance is preserved.
            let existing = &mut g.graph[idx];
            if !existing.aliases.contains(&compound_id) {
                existing.aliases.push(compound_id.clone());
            }
            new_indices.push(idx);
        }

        // Rewire incoming edges — fan each one out to every expanded extern.
        let inbound: Vec<_> = g
            .graph
            .edges_directed(compound_idx, petgraph::Direction::Incoming)
            .map(|e| (e.id(), e.source()))
            .collect();
        for (eid, src) in inbound {
            let weight = g.graph.edge_weight(eid).cloned().expect("edge");
            for &new in &new_indices {
                g.graph.add_edge(src, new, weight.clone());
            }
            g.graph.remove_edge(eid);
        }

        // Rewire outgoing edges (rare for extern nodes, but be defensive).
        let outbound: Vec<_> = g
            .graph
            .edges_directed(compound_idx, petgraph::Direction::Outgoing)
            .map(|e| (e.id(), e.target()))
            .collect();
        for (eid, dst) in outbound {
            let weight = g.graph.edge_weight(eid).cloned().expect("edge");
            for &new in &new_indices {
                g.graph.add_edge(new, dst, weight.clone());
            }
            g.graph.remove_edge(eid);
        }

        // Remove the compound node and its by_id entry.
        g.by_id.remove(&compound_id);
        g.graph.remove_node(compound_idx);
        count += expanded.len();
    }
    count
}
