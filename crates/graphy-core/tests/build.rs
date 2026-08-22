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
        signature: None,
    }
}

fn e(s: &str, t: &str) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: "calls".into(),
        confidence: Confidence::Extracted,
        attr: None,
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
fn a_node_record_arriving_after_its_edge_stub_still_carries_its_kind() {
    // An edge can reference a node id before the extraction that defines
    // that node has been processed (e.g. a cross-file `calls` edge from a
    // resolution pass, where extraction order is not definition order).
    // `add_edge_record` mints a placeholder node for an unseen endpoint;
    // the real node record that shows up later must overwrite that
    // placeholder, not be silently dropped because the id already exists.
    let caller = ExtractionOutput {
        nodes: vec![],
        edges: vec![e("b.sh::main", "a.sh::colorize")],
    };
    let callee = ExtractionOutput {
        nodes: vec![Node {
            id: "a.sh::colorize".into(),
            label: "colorize".into(),
            source_file: Some("a.sh".into()),
            source_location: Some("L3".into()),
            kind: Some("function".into()),
            signature: None,
        }],
        edges: vec![],
    };
    // `caller` is processed first, so its edge creates the stub before
    // `callee`'s authoritative node record arrives.
    let g = build_graph(vec![caller, callee]);
    let idx = g.by_id["a.sh::colorize"];
    let data = &g.graph[idx];
    assert_eq!(data.kind.as_deref(), Some("function"));
    assert_eq!(data.source_file.as_deref(), Some("a.sh"));
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
