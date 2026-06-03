//! `graph` module: KnowledgeGraph behaviour + serialization.

use graphy_core::graph::{KnowledgeGraph, NodeData};
use graphy_core::schema::{Confidence, Edge, Node};

fn node(id: &str) -> Node {
    Node {
        id: id.into(),
        label: id.into(),
        source_file: None,
        source_location: None,
        kind: None,
        signature: None,
    }
}

#[test]
fn new_graph_is_empty() {
    let g = KnowledgeGraph::new();
    assert_eq!(g.node_count(), 0);
    assert_eq!(g.edge_count(), 0);
}

#[test]
fn ensure_node_dedupes_by_id() {
    let mut g = KnowledgeGraph::new();
    let a = g.ensure_node(
        "x",
        NodeData {
            label: "X".into(),
            ..Default::default()
        },
    );
    let b = g.ensure_node(
        "x",
        NodeData {
            label: "ignored".into(),
            ..Default::default()
        },
    );
    assert_eq!(a, b);
    assert_eq!(g.node_count(), 1);
}

#[test]
fn add_node_record_inserts_once() {
    let mut g = KnowledgeGraph::new();
    g.add_node_record(node("a"));
    g.add_node_record(node("a"));
    assert_eq!(g.node_count(), 1);
}

#[test]
fn add_edge_record_inserts_missing_endpoints() {
    let mut g = KnowledgeGraph::new();
    g.add_edge_record(Edge {
        source: "a".into(),
        target: "b".into(),
        relation: "calls".into(),
        confidence: Confidence::Extracted,
        attr: None,
    });
    assert_eq!(g.node_count(), 2);
    assert_eq!(g.edge_count(), 1);
}

#[test]
fn parallel_edges_are_allowed() {
    let mut g = KnowledgeGraph::new();
    for _ in 0..3 {
        g.add_edge_record(Edge {
            source: "a".into(),
            target: "b".into(),
            relation: "calls".into(),
            confidence: Confidence::Extracted,
            attr: None,
        });
    }
    assert_eq!(g.edge_count(), 3);
}

#[test]
fn to_json_value_round_trip_preserves_structure() {
    let mut g = KnowledgeGraph::new();
    g.add_node_record(Node {
        id: "a".into(),
        label: "Alpha".into(),
        source_file: Some("x.rs".into()),
        source_location: Some("L1".into()),
        kind: Some("function".into()),
        signature: None,
    });
    g.add_edge_record(Edge {
        source: "a".into(),
        target: "b".into(),
        relation: "calls".into(),
        confidence: Confidence::Inferred,
        attr: None,
    });
    let v = g.to_json_value();
    let nodes = v.get("nodes").unwrap().as_array().unwrap();
    let edges = v.get("edges").unwrap().as_array().unwrap();
    assert_eq!(nodes.len(), 2);
    assert_eq!(edges.len(), 1);
    assert_eq!(edges[0].get("confidence").unwrap(), "INFERRED");
}

#[test]
fn self_loops_supported() {
    let mut g = KnowledgeGraph::new();
    g.add_edge_record(Edge {
        source: "x".into(),
        target: "x".into(),
        relation: "recurses".into(),
        confidence: Confidence::Inferred,
        attr: None,
    });
    assert_eq!(g.edge_count(), 1);
}

#[test]
fn unicode_ids_supported() {
    let mut g = KnowledgeGraph::new();
    g.add_node_record(node("ユーザ"));
    assert_eq!(g.node_count(), 1);
}
