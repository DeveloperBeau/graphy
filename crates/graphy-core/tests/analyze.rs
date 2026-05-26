//! `analyze` module: god nodes, communities, ambiguity counts.

use graphy_core::analyze::analyze;
use graphy_core::build::build_graph;
use graphy_core::cluster::cluster;
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

fn e(s: &str, t: &str, c: Confidence) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: "calls".into(),
        confidence: c,
    }
}

#[test]
fn analyze_empty_graph() {
    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    assert_eq!(a.node_count, 0);
    assert_eq!(a.edge_count, 0);
    assert!(a.god_nodes.is_empty());
    assert_eq!(a.ambiguous_edge_count, 0);
}

#[test]
fn god_nodes_sorted_by_degree_desc() {
    let nodes: Vec<Node> = (0..5).map(|i| n(&format!("v{i}"))).collect();
    let mut edges = vec![];
    // v0 is god — connected to all others.
    for i in 1..5 {
        edges.push(e("v0", &format!("v{i}"), Confidence::Extracted));
    }
    // v1 has degree 2 (one from v0, one to v2).
    edges.push(e("v1", "v2", Confidence::Extracted));
    let ex = ExtractionOutput { nodes, edges };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    assert_eq!(a.god_nodes[0].label, "v0");
    assert_eq!(a.god_nodes[0].degree, 4);
}

#[test]
fn god_nodes_capped_at_20() {
    let nodes: Vec<Node> = (0..30).map(|i| n(&format!("k{i}"))).collect();
    let edges: Vec<Edge> = (0..29)
        .map(|i| e("hub", &format!("k{i}"), Confidence::Extracted))
        .collect();
    let mut nodes = nodes;
    nodes.push(n("hub"));
    let ex = ExtractionOutput { nodes, edges };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    assert!(a.god_nodes.len() <= 20);
}

#[test]
fn ambiguous_edge_counted() {
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b")],
        edges: vec![
            e("a", "b", Confidence::Extracted),
            e("a", "b", Confidence::Ambiguous),
            e("a", "b", Confidence::Ambiguous),
        ],
    };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    assert_eq!(a.ambiguous_edge_count, 2);
}

#[test]
fn community_count_matches_cluster() {
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b"), n("c"), n("d")],
        edges: vec![e("a", "b", Confidence::Extracted)],
    };
    let mut g = build_graph(vec![ex]);
    cluster(&mut g);
    let a = analyze(&g);
    // {a,b} share component; c, d isolated → 3 communities.
    assert_eq!(a.community_count, 3);
}
