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

use std::collections::HashMap;

use petgraph::graph::NodeIndex;
use petgraph::visit::EdgeRef;

use crate::graph::KnowledgeGraph;

const MAX_INNER_PASSES: usize = 32;
const MAX_OUTER_PASSES: usize = 12;
const MIN_GAIN: f64 = 1e-7;

type Adj = Vec<Vec<(usize, f64)>>;

pub fn cluster(g: &mut KnowledgeGraph) {
    if g.graph.node_count() == 0 {
        return;
    }
    let (mut adj, mut total_weight) = build_undirected_adjacency(g);
    // `levels[k]` maps a node index at outer pass `k` to its community index
    // at the *folded* graph for pass `k+1`. Indices are renumbered to dense
    // 0..n so composition during `write_back` is a simple chained lookup.
    let mut levels: Vec<Vec<usize>> = Vec::new();

    for _ in 0..MAX_OUTER_PASSES {
        let mut community: Vec<usize> = (0..adj.len()).collect();
        let improved = local_moving_phase(&adj, &mut community, total_weight);
        densify(&mut community);
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
    for (idx, ni) in g.graph.node_indices().enumerate() {
        let raw = mapping[idx];
        let next = renumber.len() as u32;
        let c_label = *renumber.entry(raw).or_insert(next);
        g.graph[ni].community = Some(c_label);
    }
}
