//! `schema` module: Node / Edge / Confidence / ExtractionOutput.

use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

// ---------- success ----------

#[test]
fn confidence_serializes_as_uppercase() {
    let v = serde_json::to_value(Confidence::Extracted).unwrap();
    assert_eq!(v, serde_json::json!("EXTRACTED"));
    assert_eq!(Confidence::Inferred.as_str(), "INFERRED");
    assert_eq!(Confidence::Ambiguous.as_str(), "AMBIGUOUS");
    assert_eq!(Confidence::Extracted.as_str(), "EXTRACTED");
}

#[test]
fn confidence_roundtrips_through_json() {
    for c in [
        Confidence::Extracted,
        Confidence::Inferred,
        Confidence::Ambiguous,
    ] {
        let s = serde_json::to_string(&c).unwrap();
        let back: Confidence = serde_json::from_str(&s).unwrap();
        assert_eq!(c, back);
    }
}

#[test]
fn extraction_output_merge_concatenates() {
    let mut a = ExtractionOutput {
        nodes: vec![node("a")],
        edges: vec![],
    };
    let b = ExtractionOutput {
        nodes: vec![node("b")],
        edges: vec![edge("a", "b", "uses", Confidence::Extracted)],
    };
    a.merge(b);
    assert_eq!(a.nodes.len(), 2);
    assert_eq!(a.edges.len(), 1);
    assert_eq!(a.edges[0].relation, "uses");
}

#[test]
fn node_serialize_skips_none_fields() {
    let n = Node {
        id: "id".into(),
        label: "lbl".into(),
        source_file: None,
        source_location: None,
        kind: None,
        signature: None,
    };
    let s = serde_json::to_string(&n).unwrap();
    assert!(!s.contains("source_file"));
    assert!(!s.contains("source_location"));
    assert!(!s.contains("kind"));
    assert!(!s.contains("signature"));
}

#[test]
fn edge_serialize_skips_none_attr() {
    let e = Edge {
        source: "a".into(),
        target: "b".into(),
        relation: "calls".into(),
        confidence: Confidence::Inferred,
        attr: None,
    };
    let s = serde_json::to_string(&e).unwrap();
    assert!(!s.contains("attr"));
}

// ---------- edge ----------

#[test]
fn extraction_output_default_is_empty() {
    let e = ExtractionOutput::default();
    assert!(e.nodes.is_empty());
    assert!(e.edges.is_empty());
}

#[test]
fn extraction_output_deserialize_accepts_missing_arrays() {
    let v: ExtractionOutput = serde_json::from_str("{}").unwrap();
    assert!(v.nodes.is_empty() && v.edges.is_empty());
}

// ---------- failure ----------

#[test]
fn confidence_rejects_unknown_variant() {
    let r: Result<Confidence, _> = serde_json::from_str("\"GUESSED\"");
    assert!(r.is_err());
}

#[test]
fn confidence_rejects_lowercase() {
    let r: Result<Confidence, _> = serde_json::from_str("\"extracted\"");
    assert!(r.is_err());
}

#[test]
fn edge_requires_all_fields() {
    let r: Result<Edge, _> = serde_json::from_str(r#"{"source":"a"}"#);
    assert!(r.is_err());
}

// ---------- hostile ----------

#[test]
fn extraction_output_survives_huge_node_payload() {
    let mut e = ExtractionOutput::default();
    for i in 0..50_000 {
        e.nodes.push(node(&format!("n{i}")));
    }
    let s = serde_json::to_string(&e).unwrap();
    let back: ExtractionOutput = serde_json::from_str(&s).unwrap();
    assert_eq!(back.nodes.len(), 50_000);
}

#[test]
fn extraction_output_accepts_unicode_and_emoji_labels() {
    let n = Node {
        id: "id".into(),
        label: "日本語 🦀".into(),
        ..node("id")
    };
    let s = serde_json::to_string(&n).unwrap();
    assert!(s.contains("日本語"));
}

// helpers
fn node(id: &str) -> Node {
    Node {
        id: id.into(),
        label: id.into(),
        source_file: None,
        source_location: None,
        kind: None,
        signature: None,
    }
}

fn edge(s: &str, t: &str, rel: &str, c: Confidence) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: rel.into(),
        confidence: c,
        attr: None,
    }
}
