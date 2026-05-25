use graphy_core::dedup::map::{DedupMap, Redirect};
use graphy_core::dedup::map::apply_dedup_map;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

#[test]
fn dedup_map_roundtrips_through_serde() {
    let m = DedupMap {
        version: 1,
        for_extraction: "blake3:abc".into(),
        redirects: vec![Redirect {
            from: "extern::a::b".into(),
            to: "src/a.rs::b".into(),
            edge_relation: None,
            confidence_downgrade: true,
        }],
        ambiguous_marked: vec!["src/c.rs::helper".into()],
    };
    let json = serde_json::to_string(&m).unwrap();
    let back: DedupMap = serde_json::from_str(&json).unwrap();
    assert_eq!(back.redirects.len(), 1);
    assert_eq!(back.ambiguous_marked, vec!["src/c.rs::helper"]);
}

#[test]
fn dedup_map_apply_redirects_node_drop_and_edge_retarget() {
    let mut out = ExtractionOutput {
        nodes: vec![
            Node { id: "extern::a::b".into(), label: "b".into(),
                source_file: Some("src/x.rs".into()), source_location: Some("L1".into()),
                kind: Some("import".into()) },
            Node { id: "src/x.rs::caller".into(), label: "caller".into(),
                source_file: Some("src/x.rs".into()), source_location: Some("L5".into()),
                kind: Some("function".into()) },
        ],
        edges: vec![Edge {
            source: "src/x.rs::caller".into(),
            target: "extern::a::b".into(),
            relation: "imports".into(),
            confidence: Confidence::Extracted,
        }],
    };
    let m = DedupMap {
        version: 1, for_extraction: "blake3:1".into(),
        redirects: vec![Redirect {
            from: "extern::a::b".into(),
            to: "src/a.rs::b".into(),
            edge_relation: None,
            confidence_downgrade: true,
        }],
        ambiguous_marked: vec![],
    };
    apply_dedup_map(&mut out, &m);
    assert_eq!(out.nodes.len(), 1, "extern node should be dropped");
    assert_eq!(out.edges[0].target, "src/a.rs::b");
    assert!(matches!(out.edges[0].confidence, Confidence::Inferred));
}

#[test]
fn dedup_map_apply_no_op_on_empty_map() {
    let mut out = ExtractionOutput {
        nodes: vec![Node { id: "x".into(), label: "x".into(),
            source_file: None, source_location: None, kind: None }],
        edges: vec![],
    };
    apply_dedup_map(&mut out, &DedupMap::empty_for("blake3:0"));
    assert_eq!(out.nodes.len(), 1);
}

#[test]
fn dedup_map_apply_marks_ambiguous() {
    let mut out = ExtractionOutput {
        nodes: vec![Node { id: "src/c.rs::helper".into(), label: "helper".into(),
            source_file: Some("src/c.rs".into()), source_location: Some("L1".into()),
            kind: Some("function".into()) }],
        edges: vec![],
    };
    let m = DedupMap {
        version: 1, for_extraction: "blake3:1".into(),
        redirects: vec![],
        ambiguous_marked: vec!["src/c.rs::helper".into()],
    };
    apply_dedup_map(&mut out, &m);
    assert_eq!(out.nodes[0].kind.as_deref(), Some("function?ambiguous"));
}

#[test]
fn dedup_map_apply_handles_unknown_redirect_target() {
    // A redirect whose `from` id is not present in the extraction should
    // be ignored without panic.
    let mut out = ExtractionOutput {
        nodes: vec![Node { id: "real".into(), label: "real".into(),
            source_file: None, source_location: None, kind: None }],
        edges: vec![],
    };
    let m = DedupMap {
        version: 1, for_extraction: "blake3:1".into(),
        redirects: vec![Redirect {
            from: "ghost".into(), to: "elsewhere".into(),
            edge_relation: None, confidence_downgrade: false,
        }],
        ambiguous_marked: vec![],
    };
    apply_dedup_map(&mut out, &m);
    assert_eq!(out.nodes.len(), 1);
}
