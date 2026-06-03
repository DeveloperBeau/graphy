//! Strongly-connected component index tests.

use graphy_core::build::build_graph;
use graphy_core::graph::EdgeData;
use graphy_core::scc::SccIndex;
use graphy_core::schema::*;

fn cycle3() -> graphy_core::graph::KnowledgeGraph {
    let ex = ExtractionOutput {
        nodes: vec![
            Node {
                id: "A".into(),
                label: "A".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
            Node {
                id: "B".into(),
                label: "B".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
            Node {
                id: "C".into(),
                label: "C".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
        ],
        edges: vec![
            Edge {
                source: "A".into(),
                target: "B".into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "B".into(),
                target: "C".into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "C".into(),
                target: "A".into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            },
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
    assert_eq!(
        comp,
        vec!["A".to_string(), "B".to_string(), "C".to_string()]
    );
}

#[test]
fn scc_component_of_inside_cycle() {
    let g = cycle3();
    let scc = SccIndex::build(&g);
    let mut got: Vec<String> = scc
        .component_of("B")
        .into_iter()
        .map(String::from)
        .collect();
    got.sort();
    assert_eq!(got, vec!["A".to_string(), "B".to_string(), "C".to_string()]);
}

#[test]
fn scc_acyclic_graph_has_no_multi_node_components() {
    let ex = ExtractionOutput {
        nodes: vec![
            Node {
                id: "A".into(),
                label: "A".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
            Node {
                id: "B".into(),
                label: "B".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
        ],
        edges: vec![Edge {
            source: "A".into(),
            target: "B".into(),
            relation: "calls".into(),
            confidence: Confidence::Extracted,
            attr: None,
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
    use std::fs;
    use tempfile::tempdir;
    let dir = tempdir().unwrap();
    let cache = dir.path().join("graphy-out").join(".cache");
    fs::create_dir_all(&cache).unwrap();
    fs::write(
        cache.join("scc.json"),
        r#"{"components":[],"by_id":{},"version":99}"#,
    )
    .unwrap();
    assert!(SccIndex::load(dir.path()).is_none());
}

#[test]
fn scc_build_handles_thousand_nodes_under_one_second() {
    use std::time::Instant;
    let mut nodes = Vec::new();
    let mut edges = Vec::new();
    for i in 0..1000 {
        nodes.push(Node {
            id: format!("n{i}"),
            label: format!("n{i}"),
            source_file: None,
            source_location: None,
            kind: Some("function".into()),
            signature: None,
        });
        if i > 0 {
            edges.push(Edge {
                source: format!("n{}", i - 1),
                target: format!("n{i}"),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            });
        }
    }
    // Close a 100-node cycle on tail.
    edges.push(Edge {
        source: "n999".into(),
        target: "n900".into(),
        relation: "calls".into(),
        confidence: Confidence::Extracted,
        attr: None,
    });
    let g = build_graph(vec![ExtractionOutput { nodes, edges }]);
    let start = Instant::now();
    let scc = SccIndex::build(&g);
    let elapsed = start.elapsed();
    assert!(elapsed.as_millis() < 1000, "build took {:?}", elapsed);
    assert_eq!(scc.components.len(), 1);
    assert_eq!(scc.components[0].len(), 100);
}

#[test]
fn scc_patch_after_adding_cycle_edge() {
    // Start acyclic: A → B → C.
    let ex = ExtractionOutput {
        nodes: vec![
            Node {
                id: "A".into(),
                label: "A".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
            Node {
                id: "B".into(),
                label: "B".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
            Node {
                id: "C".into(),
                label: "C".into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            },
        ],
        edges: vec![
            Edge {
                source: "A".into(),
                target: "B".into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            },
            Edge {
                source: "B".into(),
                target: "C".into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            },
        ],
    };
    let mut g = build_graph(vec![ex]);
    let mut scc = SccIndex::build(&g);
    assert!(scc.components.is_empty());

    // Add the closing edge C → A.
    let a = g.by_id["A"];
    let c = g.by_id["C"];
    g.graph.add_edge(
        c,
        a,
        EdgeData {
            relation: "calls".into(),
            confidence: Confidence::Extracted,
        },
    );

    scc.patch(&g, &["A".to_string(), "C".to_string()]);
    assert_eq!(scc.components.len(), 1);
    let mut comp = scc.components[0].clone();
    comp.sort();
    assert_eq!(
        comp,
        vec!["A".to_string(), "B".to_string(), "C".to_string()]
    );
}

#[test]
fn scc_patch_after_removing_cycle_edge() {
    let mut g = cycle3();
    let mut scc = SccIndex::build(&g);
    assert_eq!(scc.components.len(), 1);
    let c = g.by_id["C"];
    let a = g.by_id["A"];
    let eid = g.graph.find_edge(c, a).unwrap();
    g.graph.remove_edge(eid);
    scc.patch(&g, &["A".to_string(), "C".to_string()]);
    assert!(
        scc.components.is_empty(),
        "cycle should be gone after edge removal"
    );
}

#[test]
fn scc_patch_merges_two_smaller_components() {
    // Two disjoint cycles: A↔B and C↔D.
    let ex = ExtractionOutput {
        nodes: vec!["A", "B", "C", "D"]
            .into_iter()
            .map(|id| Node {
                id: id.into(),
                label: id.into(),
                source_file: None,
                source_location: None,
                kind: Some("function".into()),
                signature: None,
            })
            .collect(),
        edges: vec![("A", "B"), ("B", "A"), ("C", "D"), ("D", "C")]
            .into_iter()
            .map(|(s, t)| Edge {
                source: s.into(),
                target: t.into(),
                relation: "calls".into(),
                confidence: Confidence::Extracted,
                attr: None,
            })
            .collect(),
    };
    let mut g = build_graph(vec![ex]);
    let mut scc = SccIndex::build(&g);
    assert_eq!(scc.components.len(), 2);

    // Add B→C and D→B to merge them into one giant SCC.
    let b = g.by_id["B"];
    let c = g.by_id["C"];
    let d = g.by_id["D"];
    g.graph.add_edge(
        b,
        c,
        EdgeData {
            relation: "calls".into(),
            confidence: Confidence::Extracted,
        },
    );
    g.graph.add_edge(
        d,
        b,
        EdgeData {
            relation: "calls".into(),
            confidence: Confidence::Extracted,
        },
    );

    scc.patch(&g, &["B".to_string(), "C".to_string(), "D".to_string()]);
    assert_eq!(scc.components.len(), 1);
    assert_eq!(scc.components[0].len(), 4);
}

#[test]
fn scc_patch_splits_when_node_removed() {
    // Cycle A→B→C→A. Remove node B → no cycle remains.
    let mut g = cycle3();
    let mut scc = SccIndex::build(&g);
    assert_eq!(scc.components.len(), 1);

    // Remove B and its incident edges (petgraph removes incident edges
    // automatically when remove_node is called).
    let b = g.by_id["B"];
    g.graph.remove_node(b);
    g.by_id.remove("B");

    // Patch must be told about A/C (community context loss) AND B (the
    // removed id) so the prior component is invalidated in the SCC index.
    scc.patch(&g, &["A".to_string(), "B".to_string(), "C".to_string()]);

    assert!(
        scc.components.is_empty(),
        "expected no cycles after removing B, got {:?}",
        scc.components
    );
    assert!(!scc.by_id.contains_key("B"));
}
