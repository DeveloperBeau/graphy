//! `cache` module: content-hash persistence.

use std::fs;
use std::path::PathBuf;

use graphy_core::cache::Cache;
use graphy_core::schema::{ExtractionOutput, Node};
use graphy_core::{Pipeline, PipelineConfig};
use tempfile::tempdir;

fn ex(nodes: &[&str]) -> ExtractionOutput {
    ExtractionOutput {
        nodes: nodes
            .iter()
            .map(|id| Node {
                id: id.to_string(),
                label: id.to_string(),
                source_file: None,
                source_location: None,
                kind: None,
                signature: None,
            })
            .collect(),
        edges: vec![],
    }
}

#[test]
fn first_partition_marks_everything_uncached() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();
    let mut cache = Cache::open(dir.path()).unwrap();
    let part = cache.partition(std::slice::from_ref(&p));
    assert!(part.cached.is_empty());
    assert_eq!(part.uncached, vec![p]);
}

#[test]
fn unchanged_file_returns_cached_output_on_second_run() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();

    let mut cache = Cache::open(dir.path()).unwrap();
    let _ = cache.partition(std::slice::from_ref(&p));
    cache.save(&p, &ex(&["a"])).unwrap();
    cache.flush().unwrap();

    let mut reopen = Cache::open(dir.path()).unwrap();
    let part = reopen.partition(std::slice::from_ref(&p));
    assert_eq!(part.cached.len(), 1);
    assert_eq!(part.cached[0].1.nodes[0].id, "a");
    assert!(part.uncached.is_empty());
}

#[test]
fn content_change_invalidates_cache_entry() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();

    let mut cache = Cache::open(dir.path()).unwrap();
    let _ = cache.partition(std::slice::from_ref(&p));
    cache.save(&p, &ex(&["a"])).unwrap();
    cache.flush().unwrap();

    // Mutate file → hash differs → entry invalidated.
    fs::write(&p, "fn g(){}").unwrap();
    let mut reopen = Cache::open(dir.path()).unwrap();
    let part = reopen.partition(std::slice::from_ref(&p));
    assert!(part.cached.is_empty());
    assert_eq!(part.uncached.len(), 1);
}

#[test]
fn missing_file_routed_to_uncached_without_error() {
    let dir = tempdir().unwrap();
    let mut cache = Cache::open(dir.path()).unwrap();
    let part = cache.partition(&[PathBuf::from("/no/such/file.rs")]);
    assert_eq!(part.uncached.len(), 1);
    assert!(part.cached.is_empty());
}

#[test]
fn empty_partition_is_safe() {
    let dir = tempdir().unwrap();
    let mut cache = Cache::open(dir.path()).unwrap();
    let part = cache.partition(&[]);
    assert!(part.cached.is_empty() && part.uncached.is_empty());
    cache.flush().unwrap();
}

#[test]
fn cache_loads_v1_manifest_without_dedup_map() {
    let dir = tempdir().unwrap();
    let cache_dir = dir.path().join("graphy-out").join(".cache");
    fs::create_dir_all(&cache_dir).unwrap();
    fs::write(
        cache_dir.join("manifest.json"),
        r#"{"entries":{"a.rs":"blake3:xyz"}}"#,
    )
    .unwrap();
    let mut c = Cache::open(dir.path()).unwrap();
    let _ = c.partition(&[]);
    // Should not panic; the v1 manifest is accepted.
}

#[test]
fn cache_writes_current_abi_manifest_on_save() {
    let dir = tempdir().unwrap();
    let mut c = Cache::open(dir.path()).unwrap();
    c.flush().unwrap();
    let body = fs::read_to_string(
        dir.path()
            .join("graphy-out")
            .join(".cache")
            .join("manifest.json"),
    )
    .unwrap();
    assert!(body.contains("\"abi_version\": 3"));
}

#[test]
fn dedup_map_save_and_load_roundtrip_through_cache() {
    use graphy_core::dedup::map::DedupMap;
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();
    let mut c = Cache::open(dir.path()).unwrap();
    let _ = c.partition(std::slice::from_ref(&p));
    let m = DedupMap {
        version: 1,
        for_extraction: "blake3:test".into(),
        redirects: vec![],
        ambiguous_marked: vec!["abc".into()],
    };
    // Save() must run first so the manifest knows file -> hash mapping
    c.save(&p, &graphy_core::schema::ExtractionOutput::default())
        .unwrap();
    c.save_dedup_map(&p, &m).unwrap();
    c.flush().unwrap();
    let c2 = Cache::open(dir.path()).unwrap();
    let back = c2.load_dedup_map(&p).unwrap();
    assert_eq!(back.ambiguous_marked, vec!["abc"]);
}

#[test]
fn manifest_from_a_different_abi_is_discarded() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();

    let mut c = Cache::open(dir.path()).unwrap();
    let _ = c.partition(std::slice::from_ref(&p));
    c.save(&p, &ex(&["a"])).unwrap();
    c.flush().unwrap();

    let manifest_path = dir
        .path()
        .join("graphy-out")
        .join(".cache")
        .join("manifest.json");
    let body = fs::read_to_string(&manifest_path).unwrap();
    let downgraded = body.replace("\"abi_version\": 3", "\"abi_version\": 2");
    assert_ne!(
        body, downgraded,
        "test setup did not find abi_version: 3 to downgrade"
    );
    fs::write(&manifest_path, downgraded).unwrap();

    let mut reopened = Cache::open(dir.path()).unwrap();
    let part = reopened.partition(std::slice::from_ref(&p));
    assert!(
        part.cached.is_empty(),
        "a manifest from a stale ABI must be discarded"
    );
    assert_eq!(part.uncached, vec![p.clone()]);

    // False positive guard: a manifest at the current ABI with a matching
    // blob on disk must still be honoured.
    let mut fresh = Cache::open(dir.path()).unwrap();
    let _ = fresh.partition(std::slice::from_ref(&p));
    fresh.save(&p, &ex(&["a"])).unwrap();
    fresh.flush().unwrap();
    let mut reopened2 = Cache::open(dir.path()).unwrap();
    let part2 = reopened2.partition(std::slice::from_ref(&p));
    assert_eq!(part2.cached.len(), 1, "current-ABI manifest must be used");
}

#[test]
fn manifest_is_stale_reports_absent_as_fresh() {
    let dir = tempdir().unwrap();
    assert!(!graphy_core::cache::manifest_is_stale(dir.path()));

    let cache_dir = dir.path().join("graphy-out").join(".cache");
    fs::create_dir_all(&cache_dir).unwrap();
    fs::write(
        cache_dir.join("manifest.json"),
        r#"{"abi_version": 2, "entries": {}}"#,
    )
    .unwrap();
    assert!(graphy_core::cache::manifest_is_stale(dir.path()));

    fs::write(
        cache_dir.join("manifest.json"),
        r#"{"abi_version": 3, "entries": {}}"#,
    )
    .unwrap();
    assert!(!graphy_core::cache::manifest_is_stale(dir.path()));
}

#[test]
fn stale_cache_forces_a_full_rebuild_over_a_poisoned_graph() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let _ = Pipeline::new(cfg.clone()).run().unwrap();

    let manifest_path = dir
        .path()
        .join("graphy-out")
        .join(".cache")
        .join("manifest.json");
    let manifest_body = fs::read_to_string(&manifest_path).unwrap();
    let downgraded = manifest_body.replace("\"abi_version\": 3", "\"abi_version\": 2");
    assert_ne!(
        manifest_body, downgraded,
        "test setup did not find abi_version: 3 to downgrade"
    );
    fs::write(&manifest_path, downgraded).unwrap();

    let graph_path = dir.path().join("graphy-out").join("graph.json");
    let mut graph_value: serde_json::Value =
        serde_json::from_str(&fs::read_to_string(&graph_path).unwrap()).unwrap();
    graph_value["nodes"]
        .as_array_mut()
        .unwrap()
        .push(serde_json::json!({"id": "./ghost.rs::x", "label": "x"}));
    fs::write(&graph_path, serde_json::to_string(&graph_value).unwrap()).unwrap();

    let cfg2 = PipelineConfig::new(dir.path());
    let out = Pipeline::new(cfg2).run().unwrap();
    let ids: Vec<String> = out.graph.to_json_value()["nodes"]
        .as_array()
        .unwrap()
        .iter()
        .map(|n| n["id"].as_str().unwrap().to_string())
        .collect();
    assert!(
        !ids.contains(&"./ghost.rs::x".to_string()),
        "poisoned prior graph node survived: {ids:?}"
    );
}
