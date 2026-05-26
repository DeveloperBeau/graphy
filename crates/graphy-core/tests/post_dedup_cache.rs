use graphy_core::dedup::map::apply_dedup_map;
use graphy_core::dedup::map::{DedupMap, Redirect};
use graphy_core::pipeline::{Pipeline, PipelineConfig};
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use std::fs;
use tempfile::tempdir;

// ---------------------------------------------------------------------------
// Regression test: warm imports_resolved must not exceed cold
// ---------------------------------------------------------------------------

/// The core regression: after a cold build and one or more warm incremental
/// runs with no file changes, the dedup pass should resolve 0 imports on the
/// warm run.  Prior to the fix, warm runs resolved MORE imports than cold
/// because:
/// 1. `redirect_node` rebuilt `by_id` using `canonical_id_of`, which renamed
///    `extern::X` entries to `source_file::label` — creating phantom non-extern
///    nodes in `graph.json`.  Those phantoms then appeared in the suffix index
///    on warm runs, making previously-ambiguous externs resolvable.
/// 2. Dedup maps were only attributed to the file whose extern node happened
///    to survive splice-time dedup, so other files carrying the same extern id
///    in their raw extractions never got the redirect in their cache maps.
#[test]
fn warm_run_imports_resolved_is_le_cold() {
    let dir = tempdir().unwrap();
    // Two-file fixture where b.rs imports from a.rs via an extern node.
    fs::write(dir.path().join("a.rs"), "pub fn helper(){}\n").unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());

    // Cold run.
    let cold = Pipeline::new(cfg.clone()).run().unwrap();
    let cold_resolved = cold.analysis.dedup_imports_resolved;

    // Warm run (no file changes).
    let warm = Pipeline::new(cfg.clone()).run().unwrap();
    let warm_resolved = warm.analysis.dedup_imports_resolved;

    assert!(
        warm_resolved <= cold_resolved,
        "warm imports_resolved ({warm_resolved}) must be <= cold ({cold_resolved})"
    );

    // A fully-converged warm run (second warm, no changes) should resolve 0.
    let warm2 = Pipeline::new(cfg).run().unwrap();
    assert_eq!(
        warm2.analysis.dedup_imports_resolved, 0,
        "second warm run should resolve 0 imports (cache fully converged)"
    );
}

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
            Node {
                id: "extern::a::b".into(),
                label: "b".into(),
                source_file: Some("src/x.rs".into()),
                source_location: Some("L1".into()),
                kind: Some("import".into()),
            },
            Node {
                id: "src/x.rs::caller".into(),
                label: "caller".into(),
                source_file: Some("src/x.rs".into()),
                source_location: Some("L5".into()),
                kind: Some("function".into()),
            },
        ],
        edges: vec![Edge {
            source: "src/x.rs::caller".into(),
            target: "extern::a::b".into(),
            relation: "imports".into(),
            confidence: Confidence::Extracted,
        }],
    };
    let m = DedupMap {
        version: 1,
        for_extraction: "blake3:1".into(),
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
        nodes: vec![Node {
            id: "x".into(),
            label: "x".into(),
            source_file: None,
            source_location: None,
            kind: None,
        }],
        edges: vec![],
    };
    apply_dedup_map(&mut out, &DedupMap::empty_for("blake3:0"));
    assert_eq!(out.nodes.len(), 1);
}

#[test]
fn dedup_map_apply_marks_ambiguous() {
    let mut out = ExtractionOutput {
        nodes: vec![Node {
            id: "src/c.rs::helper".into(),
            label: "helper".into(),
            source_file: Some("src/c.rs".into()),
            source_location: Some("L1".into()),
            kind: Some("function".into()),
        }],
        edges: vec![],
    };
    let m = DedupMap {
        version: 1,
        for_extraction: "blake3:1".into(),
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
        nodes: vec![Node {
            id: "real".into(),
            label: "real".into(),
            source_file: None,
            source_location: None,
            kind: None,
        }],
        edges: vec![],
    };
    let m = DedupMap {
        version: 1,
        for_extraction: "blake3:1".into(),
        redirects: vec![Redirect {
            from: "ghost".into(),
            to: "elsewhere".into(),
            edge_relation: None,
            confidence_downgrade: false,
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
    fs::write(
        dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Trigger an incremental pass.
    let _ = Pipeline::new(cfg).run().unwrap();
    // At least one .dedup.json file should be on disk by now.
    let cache_dir = dir.path().join("graphy-out").join(".cache");
    let entries: Vec<_> = fs::read_dir(&cache_dir)
        .unwrap()
        .filter_map(|e| e.ok())
        .filter(|e| e.file_name().to_string_lossy().ends_with(".dedup.json"))
        .collect();
    assert!(
        !entries.is_empty(),
        "expected at least one .dedup.json file in {cache_dir:?}"
    );
    // And the content should be a parseable DedupMap.
    let body = fs::read_to_string(entries[0].path()).unwrap();
    let _map: graphy_core::dedup::map::DedupMap = serde_json::from_str(&body).unwrap();
    // For this fixture (b.rs imports from a.rs), we expect a redirect to
    // be recorded on b.rs's map. But we don't know whether entries[0] is
    // a.rs or b.rs without sorting, so just check at least one map has
    // non-empty redirects.
    let any_populated: bool = entries.iter().any(|e| {
        let body = fs::read_to_string(e.path()).unwrap();
        let m: graphy_core::dedup::map::DedupMap = serde_json::from_str(&body).unwrap();
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
        &fs::read_to_string(dir.path().join("graphy-out/.cache/manifest.json")).unwrap(),
    )
    .unwrap();
    let current_hash = manifest["entries"][a.to_string_lossy().as_ref()]
        .as_str()
        .unwrap();
    let map_path = dir
        .path()
        .join(format!("graphy-out/.cache/{}.dedup.json", current_hash));
    assert!(map_path.exists(), "fresh dedup map should be written");
}

#[test]
fn dedup_map_survives_unrelated_file_change() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn helper(){}\n").unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Capture b.rs's dedup map hash.
    let manifest_before =
        std::fs::read_to_string(dir.path().join("graphy-out/.cache/manifest.json")).unwrap();
    let hash_b_before: serde_json::Value = serde_json::from_str(&manifest_before).unwrap();
    // Touch a.rs only.
    fs::write(
        dir.path().join("a.rs"),
        "pub fn helper(){}\npub fn extra(){}\n",
    )
    .unwrap();
    let _ = Pipeline::new(cfg).run().unwrap();
    let manifest_after: serde_json::Value = serde_json::from_str(
        &std::fs::read_to_string(dir.path().join("graphy-out/.cache/manifest.json")).unwrap(),
    )
    .unwrap();
    let b_path = dir.path().join("b.rs");
    let b_key = b_path.to_string_lossy().to_string();
    assert_eq!(
        hash_b_before["entries"][&b_key], manifest_after["entries"][&b_key],
        "b.rs hash should be unchanged"
    );
}

#[test]
fn ambiguous_marked_survives_warm_run() {
    // Three files: a.rs and b.rs each define `helper` (no connecting import),
    // so dedup flags them ambiguous.  c.rs imports `helper` via an extern,
    // giving c.rs entries in both file_extern_ids (redirect) and potentially
    // ambiguous_marked.  After a warm run the per-file maps for a.rs and b.rs
    // must still carry ambiguous_marked — the warm writeback must not drop them.
    //
    // Note: a.rs and b.rs intentionally have DIFFERENT content so the cache
    // assigns each a distinct content-hash and a distinct .dedup.json file.
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("a.rs"),
        "// module a\npub fn helper() -> u32 { 1 }\n",
    )
    .unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "// module b\npub fn helper() -> u32 { 2 }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();
    // Second run; ambiguous_marked must survive.
    let _ = Pipeline::new(cfg).run().unwrap();
    // Walk all .dedup.json files and assert at least two carry
    // ambiguous_marked entries (one for a.rs, one for b.rs).
    let cache_dir = dir.path().join("graphy-out").join(".cache");
    let mut total_ambiguous = 0;
    for entry in fs::read_dir(&cache_dir).unwrap().filter_map(|e| e.ok()) {
        let name = entry.file_name().to_string_lossy().into_owned();
        if !name.ends_with(".dedup.json") {
            continue;
        }
        let body = fs::read_to_string(entry.path()).unwrap();
        let map: graphy_core::dedup::map::DedupMap = serde_json::from_str(&body).unwrap();
        total_ambiguous += map.ambiguous_marked.len();
    }
    assert!(
        total_ambiguous >= 2,
        "expected ambiguous_marked entries on at least 2 files (a.rs, b.rs), got {total_ambiguous}"
    );
}

#[test]
fn run_full_fallback_path_dedups() {
    // Simulate the fallback case: graph.json on disk but unparseable.
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn helper(){}\n").unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "use crate::a::helper;\npub fn caller(){ helper(); }\n",
    )
    .unwrap();
    let out_dir = dir.path().join("graphy-out");
    fs::create_dir_all(&out_dir).unwrap();
    // Write a deliberately broken graph.json to force the fallback.
    fs::write(out_dir.join("graph.json"), "{not json").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _r = Pipeline::new(cfg).run().unwrap();
    // The export'd stats.json should reflect a dedup pass having run.
    let stats: serde_json::Value =
        serde_json::from_str(&fs::read_to_string(out_dir.join("stats.json")).unwrap()).unwrap();
    let resolved = stats["dedup_imports_resolved"].as_u64().unwrap_or(0);
    assert!(
        resolved >= 1,
        "run_full fallback must dedup; got dedup_imports_resolved={resolved}"
    );
}
