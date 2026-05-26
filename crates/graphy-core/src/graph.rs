//! In-memory knowledge graph (petgraph wrapper, serializable).

use std::collections::HashMap;

use indexmap::IndexMap;
use petgraph::graph::NodeIndex;
use petgraph::stable_graph::StableDiGraph;
use serde::{Deserialize, Serialize};

use crate::schema::{Confidence, Edge, Node};

/// Stable petgraph alias: node indices survive `remove_node` so the
/// `by_id` map stays valid after dedup / incremental strips.
pub type DiGraph<N, E> = StableDiGraph<N, E>;

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct NodeData {
    pub label: String,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_file: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_location: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub kind: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub community: Option<u32>,
    /// Ids that previously named this entity before [`crate::dedup`]
    /// collapsed them into this node. Preserved so external tooling can
    /// resolve the original ids back to the canonical node.
    #[serde(default, skip_serializing_if = "Vec::is_empty")]
    pub aliases: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeData {
    pub relation: String,
    pub confidence: Confidence,
}

#[derive(Debug, Default)]
pub struct KnowledgeGraph {
    pub graph: DiGraph<NodeData, EdgeData>,
    pub by_id: HashMap<String, NodeIndex>,
}

impl KnowledgeGraph {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn ensure_node(&mut self, id: &str, data: NodeData) -> NodeIndex {
        if let Some(&idx) = self.by_id.get(id) {
            return idx;
        }
        let idx = self.graph.add_node(data);
        self.by_id.insert(id.to_string(), idx);
        idx
    }

    pub fn add_node_record(&mut self, n: Node) {
        self.ensure_node(
            &n.id,
            NodeData {
                label: n.label,
                source_file: n.source_file,
                source_location: n.source_location,
                kind: n.kind,
                community: None,
                aliases: Vec::new(),
            },
        );
    }

    pub fn add_edge_record(&mut self, e: Edge) {
        let s = self.ensure_node(
            &e.source,
            NodeData {
                label: e.source.clone(),
                ..Default::default()
            },
        );
        let t = self.ensure_node(
            &e.target,
            NodeData {
                label: e.target.clone(),
                ..Default::default()
            },
        );
        self.graph.add_edge(
            s,
            t,
            EdgeData {
                relation: e.relation,
                confidence: e.confidence,
            },
        );
    }

    pub fn node_count(&self) -> usize {
        self.graph.node_count()
    }

    pub fn edge_count(&self) -> usize {
        self.graph.edge_count()
    }

    /// Serialize as `{nodes:[…], edges:[…]}` — stable form for graph.json.
    pub fn to_json_value(&self) -> serde_json::Value {
        let mut by_idx: IndexMap<NodeIndex, String> = IndexMap::new();
        for (id, idx) in &self.by_id {
            by_idx.insert(*idx, id.clone());
        }
        let nodes: Vec<_> = self
            .graph
            .node_indices()
            .map(|i| {
                let d = &self.graph[i];
                let id = by_idx
                    .get(&i)
                    .cloned()
                    .unwrap_or_else(|| i.index().to_string());
                serde_json::json!({
                    "id": id,
                    "label": d.label,
                    "source_file": d.source_file,
                    "source_location": d.source_location,
                    "kind": d.kind,
                    "community": d.community,
                    "aliases": d.aliases,
                })
            })
            .collect();
        let edges: Vec<_> = self
            .graph
            .edge_indices()
            .map(|e| {
                let (s, t) = self.graph.edge_endpoints(e).unwrap();
                let d = &self.graph[e];
                serde_json::json!({
                    "source": by_idx.get(&s),
                    "target": by_idx.get(&t),
                    "relation": d.relation,
                    "confidence": d.confidence.as_str(),
                })
            })
            .collect();
        serde_json::json!({ "nodes": nodes, "edges": edges })
    }
}
