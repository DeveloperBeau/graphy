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
    pub per_file_maps: HashMap<String, DedupMap>,
}

/// Collapse externs that resolve to local definitions, merge re-exports,
/// flag ambiguous duplicates. Returns counters for the report.
pub fn dedup(g: &mut KnowledgeGraph) -> DedupReport {
    let mut per_file_maps: HashMap<String, DedupMap> = HashMap::new();
    let mut report = DedupReport::default();
    report.imports_resolved = resolve_imports(g, &mut per_file_maps);
    let (merged, ambiguous) = collapse_aliases(g, &mut per_file_maps);
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

fn resolve_imports(g: &mut KnowledgeGraph, per_file_maps: &mut HashMap<String, DedupMap>) -> usize {
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
    for extern_id in &extern_ids {
        let Some(&extern_idx) = g.by_id.get(extern_id) else { continue };
        let label = g.graph[extern_idx].label.clone();
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
    count
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

    // Drop the orphan node + its by_id entry. Removing the node
    // invalidates other NodeIndex values, so we look up by id to find it.
    g.by_id.remove(original_id);
    g.graph.remove_node(from);
    // Rebuild by_id since petgraph reuses freed indices and shifts may
    // have moved nodes. Walk every remaining node and re-record.
    g.by_id.clear();
    let mut tmp: Vec<(String, NodeIndex)> = Vec::new();
    for ni in g.graph.node_indices() {
        // Use the node's own canonical id: first alias if present, else
        // synthesise from label + source_location to remain stable.
        let id = canonical_id_of(&g.graph[ni]);
        tmp.push((id, ni));
    }
    for (id, ni) in tmp {
        g.by_id.entry(id).or_insert(ni);
    }
}

fn canonical_id_of(data: &NodeData) -> String {
    // We never lose the original "primary" id because every node stores
    // its incoming edges' source label. To make redirect_node deterministic
    // we rebuild the id from source_file + label, matching how extractors
    // emit it.
    match (&data.source_file, &data.source_location) {
        (Some(f), Some(_)) => format!("{f}::{}", data.label),
        _ => data.label.clone(),
    }
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
