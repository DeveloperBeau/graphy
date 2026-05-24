//! `report` module: markdown rendering.

use graphy_core::analyze::analyze;
use graphy_core::build::build_graph;
use graphy_core::report::render;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

fn n(id: &str) -> Node {
    Node { id: id.into(), label: id.into(), source_file: None, source_location: None, kind: None }
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
fn report_includes_summary_section() {
    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let s = render(&g, &a);
    assert!(s.contains("# GRAPH_REPORT"));
    assert!(s.contains("Nodes:"));
    assert!(s.contains("Edges:"));
}

#[test]
fn report_lists_god_nodes_in_table() {
    let ex = ExtractionOutput {
        nodes: vec![n("hub"), n("a"), n("b")],
        edges: vec![e("hub", "a"), e("hub", "b")],
    };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    let s = render(&g, &a);
    assert!(s.contains("| `hub` |"));
}

#[test]
fn report_is_pure_function() {
    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let s1 = render(&g, &a);
    let s2 = render(&g, &a);
    assert_eq!(s1, s2);
}
