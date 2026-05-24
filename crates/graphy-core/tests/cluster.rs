//! `cluster` module: community labels assigned to every node.

use graphy_core::build::build_graph;
use graphy_core::cluster::cluster;
use graphy_core::graph::KnowledgeGraph;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

fn n(id: &str) -> Node {
    Node { id: id.into(), label: id.into(), source_file: None, source_location: None, kind: None }
}

fn e(s: &str, t: &str) -> Edge {
    Edge {
        source: s.into(), target: t.into(),
        relation: "calls".into(),
        confidence: Confidence::Extracted,
    }
}

#[test]
fn empty_graph_clusters_safely() {
    let mut g = KnowledgeGraph::new();
    cluster(&mut g);
    assert_eq!(g.node_count(), 0);
}

#[test]
fn every_node_gets_a_community_label() {
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b"), n("c"), n("d")],
        edges: vec![e("a", "b"), e("c", "d")],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    for i in g.graph.node_indices() {
        assert!(g.graph[i].community.is_some());
    }
}

#[test]
fn isolated_nodes_each_get_distinct_community() {
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b"), n("c")],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    let mut comms: Vec<_> = g.graph.node_weights().filter_map(|n| n.community).collect();
    comms.sort();
    comms.dedup();
    assert_eq!(comms.len(), 3);
}

#[test]
fn dense_triangle_collapses_into_one_community() {
    // K3 (triangle) is the smallest graph where Louvain has a strictly
    // higher-modularity single-community solution than any partition.
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b"), n("c")],
        edges: vec![e("a", "b"), e("b", "c"), e("a", "c")],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    let comms: std::collections::HashSet<_> =
        g.graph.node_weights().filter_map(|n| n.community).collect();
    assert_eq!(comms.len(), 1);
}

#[test]
fn two_dense_blocks_with_weak_bridge_yield_two_communities() {
    // Two triangles joined by a single edge — canonical Louvain test case.
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b"), n("c"), n("d"), n("e"), n("f")],
        edges: vec![
            e("a", "b"), e("b", "c"), e("a", "c"),
            e("d", "e"), e("e", "f"), e("d", "f"),
            e("c", "d"),
        ],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    let comms: std::collections::HashSet<_> =
        g.graph.node_weights().filter_map(|n| n.community).collect();
    assert_eq!(comms.len(), 2);
}
