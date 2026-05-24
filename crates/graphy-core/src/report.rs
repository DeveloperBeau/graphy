//! Render GRAPH_REPORT.md from a [`KnowledgeGraph`] and [`Analysis`].

use std::fmt::Write;

use crate::analyze::Analysis;
use crate::graph::KnowledgeGraph;

pub fn render(graph: &KnowledgeGraph, a: &Analysis) -> String {
    let mut s = String::new();
    let _ = writeln!(s, "# GRAPH_REPORT");
    let _ = writeln!(s);
    let _ = writeln!(s, "## Summary");
    let _ = writeln!(s, "- Nodes: **{}**", a.node_count);
    let _ = writeln!(s, "- Edges: **{}**", a.edge_count);
    let _ = writeln!(s, "- Communities: **{}**", a.community_count);
    let _ = writeln!(s, "- Ambiguous edges: **{}**", a.ambiguous_edge_count);
    let _ = writeln!(s);
    let _ = writeln!(s, "## God nodes (top-{}, by degree)", a.god_nodes.len());
    let _ = writeln!(s, "| Label | Degree | Source |");
    let _ = writeln!(s, "|---|---:|---|");
    for n in &a.god_nodes {
        let src = graph
            .by_id
            .get(&n.id)
            .map(|&i| graph.graph[i].source_file.clone().unwrap_or_default())
            .unwrap_or_default();
        let _ = writeln!(s, "| `{}` | {} | {} |", n.label, n.degree, src);
    }
    s
}
