use graphy_core::dedup::map::{DedupMap, Redirect};
use graphy_core::dedup::map::apply_dedup_map;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use graphy_core::pipeline::{Pipeline, PipelineConfig};
use std::fs;
use tempfile::tempdir;

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

#[test]
fn incremental_run_writes_dedup_map_files() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn helper(){}\n").unwrap();
    fs::write(dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Trigger an incremental pass.
    let _ = Pipeline::new(cfg).run().unwrap();
    // At least one .dedup.json file should be on disk by now.
    let cache_dir = dir.path().join("graphy-out").join(".cache");
    let entries: Vec<_> = fs::read_dir(&cache_dir).unwrap()
        .filter_map(|e| e.ok())
        .filter(|e| e.file_name().to_string_lossy().ends_with(".dedup.json"))
        .collect();
    assert!(!entries.is_empty(),
        "expected at least one .dedup.json file in {cache_dir:?}");
    // And the content should be a parseable DedupMap.
    let body = fs::read_to_string(entries[0].path()).unwrap();
    let _map: graphy_core::dedup::map::DedupMap =
        serde_json::from_str(&body).unwrap();
    // For this fixture (b.rs imports from a.rs), we expect a redirect to
    // be recorded on b.rs's map. But we don't know whether entries[0] is
    // a.rs or b.rs without sorting, so just check at least one map has
    // non-empty redirects.
    let any_populated: bool = entries.iter().any(|e| {
        let body = fs::read_to_string(e.path()).unwrap();
        let m: graphy_core::dedup::map::DedupMap =
            serde_json::from_str(&body).unwrap();
        !m.redirects.is_empty()
    });
    assert!(any_populated, "expected at least one map with redirects");
}

#[test]
fn dedup_map_invalidated_on_file_content_change() {
    let dir = tempdir().unwrap();
    let a = dir.path().join("a.rs");
    fs::write(&a, "pub fn helper(){}\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    fs::write(&a, "pub fn helper(){}\npub fn extra(){}\n").unwrap();
    let _ = Pipeline::new(cfg).run().unwrap();
    // The dedup map for a.rs's *prior* hash should no longer be at the
    // current hash filename — open the manifest and verify the entry points
    // at the new hash.
    let manifest = serde_json::from_str::<serde_json::Value>(
        &fs::read_to_string(dir.path().join("graphy-out/.cache/manifest.json")).unwrap()
    ).unwrap();
    let current_hash = manifest["entries"][a.to_string_lossy().as_ref()]
        .as_str().unwrap();
    let map_path = dir.path().join(format!(
        "graphy-out/.cache/{}.dedup.json", current_hash));
    assert!(map_path.exists(), "fresh dedup map should be written");
}

#[test]
fn dedup_map_survives_unrelated_file_change() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn helper(){}\n").unwrap();
    fs::write(dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Capture b.rs's dedup map hash.
    let manifest_before = std::fs::read_to_string(
        dir.path().join("graphy-out/.cache/manifest.json")).unwrap();
    let hash_b_before: serde_json::Value =
        serde_json::from_str(&manifest_before).unwrap();
    // Touch a.rs only.
    fs::write(dir.path().join("a.rs"),
        "pub fn helper(){}\npub fn extra(){}\n").unwrap();
    let _ = Pipeline::new(cfg).run().unwrap();
    let manifest_after: serde_json::Value = serde_json::from_str(
        &std::fs::read_to_string(
            dir.path().join("graphy-out/.cache/manifest.json")).unwrap()
    ).unwrap();
    let b_path = dir.path().join("b.rs");
    let b_key = b_path.to_string_lossy().to_string();
    assert_eq!(
        hash_b_before["entries"][&b_key], manifest_after["entries"][&b_key],
        "b.rs hash should be unchanged"
    );
}
