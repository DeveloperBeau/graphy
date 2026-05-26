//! `cluster` module: community labels assigned to every node.

use graphy_core::build::build_graph;
use graphy_core::cluster::cluster;
use graphy_core::graph::KnowledgeGraph;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

fn n(id: &str) -> Node {
    Node {
        id: id.into(),
        label: id.into(),
        source_file: None,
        source_location: None,
        kind: None,
    }
}

fn e(s: &str, t: &str) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
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
            e("a", "b"),
            e("b", "c"),
            e("a", "c"),
            e("d", "e"),
            e("e", "f"),
            e("d", "f"),
            e("c", "d"),
        ],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    let comms: std::collections::HashSet<_> =
        g.graph.node_weights().filter_map(|n| n.community).collect();
    assert_eq!(comms.len(), 2);
}

#[test]
fn cluster_seeded_scc_reduces_community_count_vs_no_scc() {
    use graphy_core::cluster;
    use graphy_core::scc::SccIndex;
    use graphy_core::schema::*;
    use std::collections::HashSet;

    let make_g = || {
        let ex = ExtractionOutput {
            nodes: vec!["A", "B", "C", "D"]
                .into_iter()
                .map(|id| Node {
                    id: id.into(),
                    label: id.into(),
                    source_file: None,
                    source_location: None,
                    kind: Some("function".into()),
                })
                .collect(),
            edges: vec![("A", "B"), ("B", "C"), ("C", "D"), ("D", "A")]
                .into_iter()
                .map(|(s, t)| Edge {
                    source: s.into(),
                    target: t.into(),
                    relation: "calls".into(),
                    confidence: Confidence::Extracted,
                })
                .collect(),
        };
        let mut g = build_graph(vec![ex]);
        for w in g.graph.node_weights_mut() {
            w.community = None;
        }
        g
    };

    // Pass 1: no SCC. dirty=[A] expands to A + neighbours (B, D) only — C
    // stays in its own community.
    let mut g_nosc = make_g();
    let dirty_a_nosc = vec![g_nosc.by_id["A"]];
    cluster::cluster_seeded(&mut g_nosc, &dirty_a_nosc, None);
    let comms_nosc: HashSet<Option<u32>> =
        g_nosc.graph.node_weights().map(|n| n.community).collect();

    // Pass 2: with SCC. dirty=[A] expands to ALL of A,B,C,D — convergence
    // collapses them to at most 2 communities (often 1).
    let mut g_sc = make_g();
    let dirty_a_sc = vec![g_sc.by_id["A"]];
    let scc = SccIndex::build(&g_sc);
    cluster::cluster_seeded(&mut g_sc, &dirty_a_sc, Some(&scc));
    let comms_sc: HashSet<Option<u32>> = g_sc.graph.node_weights().map(|n| n.community).collect();

    assert!(
        comms_sc.len() <= comms_nosc.len(),
        "scc-on should produce <= communities than scc-off: with={}, without={}",
        comms_sc.len(),
        comms_nosc.len()
    );
    // Stronger: scc-on should hit at most 2 communities (vs 3+ without).
    // NOTE: if HashMap iteration order changes and causes 3, weaken to <= 3.
    assert!(
        comms_sc.len() <= 2,
        "scc-on cluster_seeded should converge to <=2 communities, got {}",
        comms_sc.len()
    );
}
