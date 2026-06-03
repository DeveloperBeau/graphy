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
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub signature: Option<crate::schema::Signature>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct EdgeData {
    pub relation: String,
    pub confidence: Confidence,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub attr: Option<crate::schema::EdgeAttr>,
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
                signature: n.signature,
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
                attr: e.attr,
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
                    "signature": d.signature,
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
                    "attr": d.attr,
                })
            })
            .collect();
        serde_json::json!({ "nodes": nodes, "edges": edges })
    }
}

#[cfg(test)]
mod plan_tests {
    use super::*;
    use crate::schema::{Confidence, Edge, EdgeAttr, Node, ParamSig, Signature};

    #[test]
    fn json_carries_signature_and_attr() {
        let mut g = KnowledgeGraph::new();
        g.add_node_record(Node {
            id: "f.rs::build".into(),
            label: "build".into(),
            kind: Some("function".into()),
            signature: Some(Signature {
                params: vec![ParamSig {
                    name: "w".into(),
                    ty: Some("Widget".into()),
                }],
                returns: Some("Widget".into()),
                fields: vec![],
            }),
            ..Default::default()
        });
        g.add_edge_record(Edge {
            source: "f.rs::build".into(),
            target: "extern::Widget".into(),
            relation: "has_param".into(),
            confidence: Confidence::Extracted,
            attr: Some(EdgeAttr {
                name: Some("w".into()),
                index: Some(0),
            }),
        });
        let v = g.to_json_value();
        let node = &v["nodes"][0];
        assert_eq!(node["signature"]["returns"], "Widget");
        let edge = v["edges"]
            .as_array()
            .unwrap()
            .iter()
            .find(|e| e["relation"] == "has_param")
            .unwrap();
        assert_eq!(edge["attr"]["name"], "w");
        assert_eq!(edge["attr"]["index"], 0);
    }
}
