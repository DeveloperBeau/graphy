//! `validate` module: extractor-output schema check.

use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use graphy_core::validate::validate;

fn node(id: &str, label: &str) -> Node {
    Node {
        id: id.into(),
        label: label.into(),
        source_file: None,
        source_location: None,
        kind: None,
    }
}

fn edge(s: &str, t: &str, rel: &str) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: rel.into(),
        confidence: Confidence::Extracted,
    }
}

// ---------- success / edge ----------

#[test]
fn validate_accepts_empty_output() {
    validate(&ExtractionOutput::default()).unwrap();
}

#[test]
fn validate_accepts_well_formed_output() {
    let ex = ExtractionOutput {
        nodes: vec![node("a", "Alpha"), node("b", "Beta")],
        edges: vec![edge("a", "b", "uses")],
    };
    validate(&ex).unwrap();
}

// ---------- failure ----------

#[test]
fn validate_rejects_empty_node_id() {
    let ex = ExtractionOutput {
        nodes: vec![node("", "L")],
        edges: vec![],
    };
    let err = validate(&ex).unwrap_err();
    assert!(err.to_string().contains("node id"));
}

#[test]
fn validate_rejects_empty_node_label() {
    let ex = ExtractionOutput {
        nodes: vec![node("id", "")],
        edges: vec![],
    };
    let err = validate(&ex).unwrap_err();
    assert!(err.to_string().contains("empty label"));
}

#[test]
fn validate_rejects_empty_edge_source() {
    let ex = ExtractionOutput {
        nodes: vec![],
        edges: vec![edge("", "b", "uses")],
    };
    let err = validate(&ex).unwrap_err();
    assert!(err.to_string().contains("source/target"));
}

#[test]
fn validate_rejects_empty_edge_target() {
    let ex = ExtractionOutput {
        nodes: vec![],
        edges: vec![edge("a", "", "uses")],
    };
    let err = validate(&ex).unwrap_err();
    assert!(err.to_string().contains("source/target"));
}

#[test]
fn validate_rejects_empty_relation() {
    let ex = ExtractionOutput {
        nodes: vec![],
        edges: vec![edge("a", "b", "")],
    };
    let err = validate(&ex).unwrap_err();
    assert!(err.to_string().contains("missing relation"));
}

// ---------- hostile ----------

#[test]
fn validate_handles_giant_input_in_reasonable_time() {
    let mut ex = ExtractionOutput::default();
    for i in 0..100_000 {
        ex.nodes.push(node(&format!("n{i}"), &format!("L{i}")));
    }
    for i in 0..50_000 {
        ex.edges
            .push(edge(&format!("n{i}"), &format!("n{}", i + 1), "calls"));
    }
    validate(&ex).unwrap();
}

#[test]
fn validate_treats_whitespace_only_as_non_empty() {
    // Whitespace is not empty — current contract. Documented here so future
    // tightening of the rule shows up as a test failure.
    let ex = ExtractionOutput {
        nodes: vec![node(" ", "  ")],
        edges: vec![],
    };
    validate(&ex).unwrap();
}
