use graphy_core::dedup::map::{DedupMap, Redirect};

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
