//! Community detection via Louvain modularity optimization.
//!
//! Louvain is a greedy modularity-maximization heuristic: every node starts in
//! its own community; in each pass we move each node to the neighboring
//! community that gives the largest modularity gain, repeating until no node
//! changes. The graph is then "folded" (each community becomes a super-node)
//! and the process repeats on the folded graph. Final community labels are
//! mapped back to the original nodes.
//!
//! Operates on the **undirected** projection of the knowledge graph because
//! modularity is defined on undirected graphs. Edge weights are taken as 1;
//! parallel edges accumulate weight.

pub mod levels;

use std::collections::{HashMap, HashSet};

use petgraph::graph::NodeIndex;
use petgraph::visit::{EdgeRef, IntoEdgeReferences};

use crate::graph::KnowledgeGraph;

const MAX_INNER_PASSES: usize = 32;
const MAX_OUTER_PASSES: usize = 12;
const MIN_GAIN: f64 = 1e-7;

type Adj = Vec<Vec<(usize, f64)>>;

pub fn cluster(g: &mut KnowledgeGraph) {
    let mut rec = crate::cluster::levels::LevelRecorder::new();
    cluster_with_recorder(g, &mut rec);
}

pub fn cluster_with_recorder(
    g: &mut KnowledgeGraph,
    recorder: &mut crate::cluster::levels::LevelRecorder,
) {
    if g.graph.node_count() == 0 {
        return;
    }
    let (mut adj, mut total_weight) = build_undirected_adjacency(g);

    // Capture base-level node-id -> super-index mapping for the recorder.
    let idx_of: HashMap<NodeIndex, usize> = g
        .graph
        .node_indices()
        .enumerate()
        .map(|(i, ni)| (ni, i))
        .collect();
    let base_map: HashMap<String, usize> = g
        .by_id
        .iter()
        .filter_map(|(id, ni)| idx_of.get(ni).map(|i| (id.clone(), *i)))
        .collect();
    recorder.record_base_map(base_map);

    // `levels[k]` maps a node index at outer pass `k` to its community index
    // at the *folded* graph for pass `k+1`. Indices are renumbered to dense
    // 0..n so composition during `write_back` is a simple chained lookup.
    let mut levels: Vec<Vec<usize>> = Vec::new();

    for _ in 0..MAX_OUTER_PASSES {
        let mut community: Vec<usize> = (0..adj.len()).collect();
        let improved = local_moving_phase(&adj, &mut community, total_weight);
        densify(&mut community);
        recorder.record_level(&adj, &community);
        levels.push(community.clone());
        if !improved {
            break;
        }
        let folded = fold(&adj, &community);
        if folded.len() == adj.len() {
            break;
        }
        total_weight = folded.iter().flatten().map(|(_, w)| *w).sum();
        adj = folded;
    }
    write_back(g, &levels);
}

/// Delta-Louvain entry point used by incremental updates. The dirty set
/// contains node indices that were freshly spliced (or whose neighbours
/// changed); their immediate neighbours form the "hot frontier" that the
/// constrained local-moving phase re-evaluates. All other nodes keep
/// their prior community label.
///
/// When the hot frontier exceeds `MAX_HOT_RATIO * n` the function falls
/// back to a full [`cluster`] pass because at that size the local pass
/// has no asymptotic advantage.
pub const MAX_HOT_RATIO: f64 = 0.25;

pub fn cluster_seeded(
    g: &mut KnowledgeGraph,
    dirty: &[NodeIndex],
    scc: Option<&crate::scc::SccIndex>,
) {
    let n = g.graph.node_count();
    if n == 0 {
        return;
    }
    let (adj, total_weight) = build_undirected_adjacency(g);

    let idx_of: HashMap<NodeIndex, usize> = g
        .graph
        .node_indices()
        .enumerate()
        .map(|(i, ni)| (ni, i))
        .collect();

    // Seed community labels from prior `node.community` values. Nodes
    // without a label (freshly spliced) get a fresh identity slot above
    // every existing label.
    let mut community: Vec<usize> = vec![0; adj.len()];
    let mut max_label: usize = 0;
    let nodes: Vec<NodeIndex> = g.graph.node_indices().collect();
    for (i, ni) in nodes.iter().enumerate() {
        if let Some(c) = g.graph[*ni].community {
            community[i] = c as usize;
            if c as usize > max_label {
                max_label = c as usize;
            }
        } else {
            // Placeholder; will be assigned a fresh id below.
            community[i] = usize::MAX;
        }
    }
    let mut next_label = max_label + 1;
    if let Some(scc) = scc {
        // Nodes in the same non-trivial SCC that are all unassigned should
        // share a single fresh label so they start co-located and Louvain
        // keeps them together instead of splitting them.
        let mut idx_to_id: HashMap<NodeIndex, String> = HashMap::with_capacity(g.by_id.len());
        for (id, &idx) in &g.by_id {
            idx_to_id.insert(idx, id.clone());
        }
        // Map SCC representative id → shared fresh label (only for components
        // where every member is currently usize::MAX).
        let mut scc_label: HashMap<String, usize> = HashMap::new();
        for (i, ni) in nodes.iter().enumerate() {
            if community[i] != usize::MAX {
                continue;
            }
            if let Some(id) = idx_to_id.get(ni) {
                let members = scc.component_of(id);
                if members.len() > 1 {
                    // Use the first member's id as the representative key.
                    let rep = members[0].to_owned();
                    let label = scc_label.entry(rep).or_insert_with(|| {
                        let l = next_label;
                        next_label += 1;
                        l
                    });
                    community[i] = *label;
                }
            }
        }
    }
    // Any still-unassigned node (singleton or no SCC index) gets its own label.
    for c in community.iter_mut() {
        if *c == usize::MAX {
            *c = next_label;
            next_label += 1;
        }
    }
    // Build the hot frontier: dirty nodes + first-order neighbours.
    let mut hot: HashSet<usize> = HashSet::new();
    for ni in dirty {
        if let Some(&i) = idx_of.get(ni) {
            hot.insert(i);
            for &(j, _) in &adj[i] {
                hot.insert(j);
            }
        }
    }

    // Check the fallback threshold using only organic churn (before SCC
    // widening), so a small dirty set inside a large cycle doesn't
    // incorrectly trigger a full re-cluster.
    let hot_ratio = hot.len() as f64 / n as f64;
    if hot_ratio > MAX_HOT_RATIO {
        // Too much churn — full pass is faster than dragging stale
        // community labels through a constrained loop.
        cluster(g);
        return;
    }

    if let Some(scc) = scc {
        // Widen the hot frontier to include every member of the same SCC
        // as any dirty node, so cycle participants are re-evaluated together.
        let mut idx_to_id: HashMap<NodeIndex, String> =
            HashMap::with_capacity(g.by_id.len());
        for (id, &idx) in &g.by_id {
            idx_to_id.insert(idx, id.clone());
        }
        let mut additions: Vec<usize> = Vec::new();
        for ni in dirty {
            if let Some(id) = idx_to_id.get(ni) {
                for member_id in scc.component_of(id) {
                    if let Some(&i) = g.by_id.get(member_id) {
                        if let Some(&local_idx) = idx_of.get(&i) {
                            additions.push(local_idx);
                        }
                    }
                }
            }
        }
        for i in additions {
            hot.insert(i);
        }
    }

    constrained_local_moving(&adj, &mut community, total_weight, &hot);
    densify(&mut community);
    write_back(g, &[community]);
}

/// Hierarchical delta-Louvain: re-cluster only nodes touched by `dirty`,
/// propagating changes up the stored level pyramid. Untouched super-nodes
/// keep their prior community assignment so disconnected components are
/// never perturbed.
pub fn cluster_hierarchical_seeded(
    g: &mut KnowledgeGraph,
    dirty: &[NodeIndex],
    prior: &crate::cluster::levels::LouvainLevels,
) {
    if g.graph.node_count() == 0 || prior.levels.is_empty() {
        return;
    }
    // Reverse map idx -> id for fast lookup.
    let mut idx_to_id: HashMap<NodeIndex, String> = HashMap::with_capacity(g.by_id.len());
    for (id, &idx) in &g.by_id {
        idx_to_id.insert(idx, id.clone());
    }
    let dirty_ids: Vec<String> = dirty
        .iter()
        .filter_map(|ni| idx_to_id.get(ni).cloned())
        .collect();
    let dirty_per_level = prior.propagate_dirty(&dirty_ids);

    let (mut adj, mut total_weight) = build_undirected_adjacency(g);
    let mut community: Vec<usize> = (0..adj.len()).collect();
    // Seed community from prior level 0 mapping.
    for (idx, ni) in g.graph.node_indices().enumerate() {
        if let Some(id) = idx_to_id.get(&ni) {
            if let Some(&c) = prior.levels[0].node_to_super.get(id) {
                if c < adj.len() {
                    community[idx] = c;
                }
            }
        }
    }
    // First level: constrained local moving over the level-0 dirty set.
    if let Some(hot) = dirty_per_level.first() {
        let hot_idx_set: HashSet<usize> = hot.iter().copied().collect();
        constrained_local_moving(&adj, &mut community, total_weight, &hot_idx_set);
    }
    densify(&mut community);
    let mut levels_out = vec![community.clone()];

    // Higher levels: each iteration folds the prior level's communities.
    for (level_idx, level) in prior.levels.iter().enumerate().skip(1) {
        let folded = fold(&adj, &community);
        if folded.len() == adj.len() {
            break;
        }
        total_weight = folded.iter().flatten().map(|(_, w)| *w).sum();
        adj = folded;
        if level.community.len() == adj.len() {
            community = level.community.clone();
        } else {
            community = (0..adj.len()).collect();
        }
        if let Some(hot) = dirty_per_level.get(level_idx) {
            let hot_idx_set: HashSet<usize> = hot.iter().copied().collect();
            constrained_local_moving(&adj, &mut community, total_weight, &hot_idx_set);
        }
        densify(&mut community);
        levels_out.push(community.clone());
    }
    write_back(g, &levels_out);
}

/// Like [`local_moving_phase`] but only iterates over `hot`. Modularity
/// gains are still computed against the *full* `sum_in` table so cold
/// nodes' contributions are not lost.
fn constrained_local_moving(
    adj: &Adj,
    community: &mut [usize],
    total_weight: f64,
    hot: &HashSet<usize>,
) {
    if total_weight == 0.0 || hot.is_empty() {
        return;
    }
    let n = adj.len();
    let mut k = vec![0.0_f64; n];
    for (i, neighbours) in adj.iter().enumerate() {
        k[i] = neighbours.iter().map(|(_, w)| *w).sum();
    }
    let mut sum_in: HashMap<usize, f64> = HashMap::new();
    for (i, &c) in community.iter().enumerate() {
        *sum_in.entry(c).or_insert(0.0) += k[i];
    }
    for _ in 0..MAX_INNER_PASSES {
        let mut moved = false;
        for &i in hot {
            let c_old = community[i];
            *sum_in.entry(c_old).or_insert(0.0) -= k[i];
            let mut to: HashMap<usize, f64> = HashMap::new();
            for &(j, w) in &adj[i] {
                if j == i {
                    continue;
                }
                *to.entry(community[j]).or_insert(0.0) += w;
            }
            let mut best_c = c_old;
            let mut best_gain = 0.0_f64;
            for (&c, &w_to_c) in &to {
                let sigma_tot = *sum_in.get(&c).unwrap_or(&0.0);
                let gain = w_to_c - sigma_tot * k[i] / total_weight;
                if gain > best_gain + MIN_GAIN {
                    best_gain = gain;
                    best_c = c;
                }
            }
            *sum_in.entry(best_c).or_insert(0.0) += k[i];
            if best_c != c_old {
                community[i] = best_c;
                moved = true;
            }
        }
        if !moved {
            break;
        }
    }
}

/// Modularity score of the current community assignment.
///
/// Used by integration tests to assert that delta-Louvain output stays
/// close to a full Louvain baseline. Returns 0.0 when the graph has no
/// edges.
pub fn modularity(g: &KnowledgeGraph) -> f64 {
    let n = g.graph.node_count();
    if n == 0 {
        return 0.0;
    }
    // Build an undirected adjacency list inline (mirrors build_undirected_adjacency).
    let mut idx_of: HashMap<NodeIndex, usize> = HashMap::with_capacity(n);
    for (i, ni) in g.graph.node_indices().enumerate() {
        idx_of.insert(ni, i);
    }
    let mut adj: Adj = vec![Vec::new(); n];
    let mut total_weight = 0.0_f64;
    for e in g.graph.edge_references() {
        let s = idx_of[&e.source()];
        let t = idx_of[&e.target()];
        if s == t {
            adj[s].push((s, 2.0));
            total_weight += 2.0;
        } else {
            adj[s].push((t, 1.0));
            adj[t].push((s, 1.0));
            total_weight += 2.0;
        }
    }
    if total_weight == 0.0 {
        return 0.0;
    }

    // Degree of each node.
    let mut k = vec![0.0_f64; n];
    for (i, nbrs) in adj.iter().enumerate() {
        k[i] = nbrs.iter().map(|(_, w)| *w).sum();
    }

    // Community label per adjacency-list index.
    let nodes: Vec<NodeIndex> = g.graph.node_indices().collect();
    let community: Vec<u32> = nodes
        .iter()
        .map(|ni| g.graph[*ni].community.unwrap_or(0))
        .collect();

    let mut q = 0.0_f64;
    for (i, nbrs) in adj.iter().enumerate() {
        for &(j, w) in nbrs {
            if community[i] == community[j] {
                q += w - k[i] * k[j] / total_weight;
            }
        }
    }
    q / total_weight
}

fn build_undirected_adjacency(g: &KnowledgeGraph) -> (Adj, f64) {
    let n = g.graph.node_count();
    let mut idx_of: HashMap<NodeIndex, usize> = HashMap::with_capacity(n);
    for (i, ni) in g.graph.node_indices().enumerate() {
        idx_of.insert(ni, i);
    }
    let mut adj: Adj = vec![Vec::new(); n];
    let mut total = 0.0_f64;
    for e in g.graph.edge_references() {
        let s = idx_of[&e.source()];
        let t = idx_of[&e.target()];
        if s == t {
            adj[s].push((s, 2.0));
            total += 2.0;
        } else {
            adj[s].push((t, 1.0));
            adj[t].push((s, 1.0));
            total += 2.0;
        }
    }
    (adj, total)
}

fn local_moving_phase(adj: &Adj, community: &mut [usize], total_weight: f64) -> bool {
    if total_weight == 0.0 {
        return false;
    }
    let n = adj.len();
    let mut k = vec![0.0_f64; n];
    for (i, neighbours) in adj.iter().enumerate() {
        k[i] = neighbours.iter().map(|(_, w)| *w).sum();
    }
    let mut sum_in: HashMap<usize, f64> = HashMap::new();
    for (i, &c) in community.iter().enumerate() {
        *sum_in.entry(c).or_insert(0.0) += k[i];
    }

    let mut improved_overall = false;
    for _ in 0..MAX_INNER_PASSES {
        let mut moved = false;
        for i in 0..n {
            let c_old = community[i];
            *sum_in.entry(c_old).or_insert(0.0) -= k[i];

            let mut to: HashMap<usize, f64> = HashMap::new();
            for &(j, w) in &adj[i] {
                if j == i {
                    continue;
                }
                *to.entry(community[j]).or_insert(0.0) += w;
            }

            let mut best_c = c_old;
            let mut best_gain = 0.0_f64;
            for (&c, &w_to_c) in &to {
                let sigma_tot = *sum_in.get(&c).unwrap_or(&0.0);
                let gain = w_to_c - sigma_tot * k[i] / total_weight;
                if gain > best_gain + MIN_GAIN {
                    best_gain = gain;
                    best_c = c;
                }
            }

            *sum_in.entry(best_c).or_insert(0.0) += k[i];
            if best_c != c_old {
                community[i] = best_c;
                moved = true;
                improved_overall = true;
            }
        }
        if !moved {
            break;
        }
    }
    improved_overall
}

/// Remap community labels in-place to dense `0..k` indices, preserving the
/// first-seen ordering so the result is deterministic for a given input.
fn densify(community: &mut [usize]) {
    let mut renumber: HashMap<usize, usize> = HashMap::new();
    for c in community.iter_mut() {
        let next = renumber.len();
        let label = *renumber.entry(*c).or_insert(next);
        *c = label;
    }
}

/// Build the folded graph: each (dense) community becomes a node, edges
/// accumulate weight.
fn fold(adj: &Adj, community: &[usize]) -> Adj {
    let k = community.iter().copied().max().map_or(0, |m| m + 1);
    let mut edge_map: HashMap<(usize, usize), f64> = HashMap::new();
    for (i, neighbours) in adj.iter().enumerate() {
        let ci = community[i];
        for &(j, w) in neighbours {
            let cj = community[j];
            let key = if ci <= cj { (ci, cj) } else { (cj, ci) };
            *edge_map.entry(key).or_insert(0.0) += w;
        }
    }
    let mut folded: Adj = vec![Vec::new(); k];
    for ((a, b), w) in edge_map {
        // Inter-community edges were counted twice (once from each endpoint).
        if a == b {
            folded[a].push((a, w));
        } else {
            let half = w / 2.0;
            folded[a].push((b, half));
            folded[b].push((a, half));
        }
    }
    folded
}

fn write_back(g: &mut KnowledgeGraph, levels: &[Vec<usize>]) {
    let n = g.graph.node_count();
    let mut mapping: Vec<usize> = (0..n).collect();
    for level in levels {
        for v in mapping.iter_mut() {
            *v = level[*v];
        }
    }
    let mut renumber: HashMap<usize, u32> = HashMap::new();
    let indices: Vec<_> = g.graph.node_indices().collect();
    for (idx, ni) in indices.into_iter().enumerate() {
        let raw = mapping[idx];
        let next = renumber.len() as u32;
        let c_label = *renumber.entry(raw).or_insert(next);
        g.graph[ni].community = Some(c_label);
    }
}
