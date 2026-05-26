//! `build` module: extraction → KnowledgeGraph merge.

use graphy_core::build::build_graph;
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
fn empty_extractions_produce_empty_graph() {
    let g = build_graph(std::iter::empty());
    assert_eq!(g.node_count(), 0);
    assert_eq!(g.edge_count(), 0);
}

#[test]
fn merges_disjoint_extractions() {
    let a = ExtractionOutput {
        nodes: vec![n("a")],
        edges: vec![],
    };
    let b = ExtractionOutput {
        nodes: vec![n("b"), n("c")],
        edges: vec![e("b", "c")],
    };
    let g = build_graph(vec![a, b]);
    assert_eq!(g.node_count(), 3);
    assert_eq!(g.edge_count(), 1);
}

#[test]
fn dedupes_nodes_across_extractions() {
    let a = ExtractionOutput {
        nodes: vec![n("x")],
        edges: vec![],
    };
    let b = ExtractionOutput {
        nodes: vec![n("x")],
        edges: vec![],
    };
    let g = build_graph(vec![a, b]);
    assert_eq!(g.node_count(), 1);
}

#[test]
fn edges_referencing_undeclared_nodes_create_them() {
    let a = ExtractionOutput {
        nodes: vec![],
        edges: vec![e("ghost1", "ghost2")],
    };
    let g = build_graph(vec![a]);
    assert_eq!(g.node_count(), 2);
    assert_eq!(g.edge_count(), 1);
}

#[test]
fn large_merge_completes_quickly() {
    let big: Vec<ExtractionOutput> = (0..200)
        .map(|i| ExtractionOutput {
            nodes: (0..50).map(|j| n(&format!("f{i}_{j}"))).collect(),
            edges: (0..40)
                .map(|j| e(&format!("f{i}_{j}"), &format!("f{i}_{}", j + 1)))
                .collect(),
        })
        .collect();
    let g = build_graph(big);
    assert_eq!(g.node_count(), 200 * 50);
    assert_eq!(g.edge_count(), 200 * 40);
}
