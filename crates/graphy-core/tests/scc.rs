//! Strongly-connected component index tests.

use graphy_core::scc::SccIndex;
use graphy_core::schema::*;
use graphy_core::build::build_graph;

fn cycle3() -> graphy_core::graph::KnowledgeGraph {
    let ex = ExtractionOutput {
        nodes: vec![
            Node { id: "A".into(), label: "A".into(), source_file: None,
                source_location: None, kind: Some("function".into()) },
            Node { id: "B".into(), label: "B".into(), source_file: None,
                source_location: None, kind: Some("function".into()) },
            Node { id: "C".into(), label: "C".into(), source_file: None,
                source_location: None, kind: Some("function".into()) },
        ],
        edges: vec![
            Edge { source: "A".into(), target: "B".into(),
                relation: "calls".into(), confidence: Confidence::Extracted },
            Edge { source: "B".into(), target: "C".into(),
                relation: "calls".into(), confidence: Confidence::Extracted },
            Edge { source: "C".into(), target: "A".into(),
                relation: "calls".into(), confidence: Confidence::Extracted },
        ],
    };
    build_graph(vec![ex])
}

#[test]
fn scc_simple_cycle_detected() {
    let g = cycle3();
    let scc = SccIndex::build(&g);
    assert_eq!(scc.components.len(), 1);
    let mut comp = scc.components[0].clone();
    comp.sort();
    assert_eq!(comp, vec!["A".to_string(), "B".to_string(), "C".to_string()]);
}

#[test]
fn scc_component_of_inside_cycle() {
    let g = cycle3();
    let scc = SccIndex::build(&g);
    let mut got: Vec<String> = scc.component_of("B").into_iter().map(String::from).collect();
    got.sort();
    assert_eq!(got, vec!["A".to_string(), "B".to_string(), "C".to_string()]);
}

#[test]
fn scc_acyclic_graph_has_no_multi_node_components() {
    let ex = ExtractionOutput {
        nodes: vec![
            Node { id: "A".into(), label: "A".into(), source_file: None,
                source_location: None, kind: Some("function".into()) },
            Node { id: "B".into(), label: "B".into(), source_file: None,
                source_location: None, kind: Some("function".into()) },
        ],
        edges: vec![Edge {
            source: "A".into(), target: "B".into(),
            relation: "calls".into(), confidence: Confidence::Extracted,
        }],
    };
    let g = build_graph(vec![ex]);
    let scc = SccIndex::build(&g);
    assert!(scc.components.is_empty());
    assert_eq!(scc.component_of("A"), vec!["A"]);
}
