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
    god_nodes.sort_by(|a, b| b.degree.cmp(&a.degree));
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
    }
}
