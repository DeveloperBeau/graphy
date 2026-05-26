//! Surface high-signal observations: god nodes, isolated clusters, ambiguous edges.

use serde::{Deserialize, Serialize};

use crate::graph::KnowledgeGraph;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Analysis {
    pub node_count: usize,
    pub edge_count: usize,
    pub community_count: usize,
    pub god_nodes: Vec<GodNode>,
    pub ambiguous_edge_count: usize,
    /// Number of `extern::*` import nodes resolved to local definitions
    /// during the dedup pass. Zero when dedup is disabled or no externs
    /// were resolved. Set by the pipeline after calling `dedup::dedup`.
    pub dedup_imports_resolved: usize,
    /// Number of glob extern nodes (`use a::*` and `from a import *`) that
    /// dedup skipped because they are unresolvable without scope analysis.
    /// Zero when dedup is disabled. Set by the pipeline.
    #[serde(default)]
    pub glob_imports_skipped: usize,
    /// Newman-modularity of the final clustered graph. Range [-1, 1].
    /// Zero when clustering is disabled or graph is empty. Set by the
    /// pipeline after `cluster::cluster`.
    #[serde(default)]
    pub modularity: f64,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct GodNode {
    pub id: String,
    pub label: String,
    pub degree: usize,
}

pub fn analyze(g: &KnowledgeGraph) -> Analysis {
    let mut god_nodes: Vec<GodNode> = g
        .by_id
        .iter()
        .map(|(id, &idx)| GodNode {
            id: id.clone(),
            label: g.graph[idx].label.clone(),
            degree: g
                .graph
                .neighbors_undirected(idx)
                .count(),
        })
        .collect();
    god_nodes.sort_by_key(|n| std::cmp::Reverse(n.degree));
    god_nodes.truncate(20);

    let communities: std::collections::HashSet<_> = g
        .graph
        .node_weights()
        .filter_map(|n| n.community)
        .collect();

    let ambiguous = g
        .graph
        .edge_weights()
        .filter(|e| matches!(e.confidence, crate::schema::Confidence::Ambiguous))
        .count();

    Analysis {
        node_count: g.node_count(),
        edge_count: g.edge_count(),
        community_count: communities.len(),
        god_nodes,
        ambiguous_edge_count: ambiguous,
        dedup_imports_resolved: 0,
        glob_imports_skipped: 0,
        modularity: 0.0,
    }
}
