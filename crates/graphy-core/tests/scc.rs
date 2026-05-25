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

#[test]
fn scc_persist_and_reload() {
    use tempfile::tempdir;
    let dir = tempdir().unwrap();
    let g = cycle3();
    let scc = SccIndex::build(&g);
    scc.save(dir.path()).unwrap();
    let loaded = SccIndex::load(dir.path()).expect("present");
    assert_eq!(scc.components, loaded.components);
}

#[test]
fn scc_load_returns_none_on_version_mismatch() {
    use tempfile::tempdir;
    use std::fs;
    let dir = tempdir().unwrap();
    let cache = dir.path().join("graphy-out").join(".cache");
    fs::create_dir_all(&cache).unwrap();
    fs::write(cache.join("scc.json"),
        r#"{"components":[],"by_id":{},"version":99}"#).unwrap();
    assert!(SccIndex::load(dir.path()).is_none());
}

#[test]
fn scc_build_handles_thousand_nodes_under_one_second() {
    use std::time::Instant;
    let mut nodes = Vec::new();
    let mut edges = Vec::new();
    for i in 0..1000 {
        nodes.push(Node {
            id: format!("n{i}"), label: format!("n{i}"),
            source_file: None, source_location: None,
            kind: Some("function".into()),
        });
        if i > 0 {
            edges.push(Edge {
                source: format!("n{}", i - 1),
                target: format!("n{i}"),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
            });
        }
    }
    // Close a 100-node cycle on tail.
    edges.push(Edge {
        source: "n999".into(), target: "n900".into(),
        relation: "calls".into(), confidence: Confidence::Extracted,
    });
    let g = build_graph(vec![ExtractionOutput { nodes, edges }]);
    let start = Instant::now();
    let scc = SccIndex::build(&g);
    let elapsed = start.elapsed();
    assert!(elapsed.as_millis() < 1000, "build took {:?}", elapsed);
    assert_eq!(scc.components.len(), 1);
    assert_eq!(scc.components[0].len(), 100);
}
