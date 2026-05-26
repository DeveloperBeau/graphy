//! `cache` module: content-hash persistence.

use std::fs;
use std::path::PathBuf;

use graphy_core::cache::Cache;
use graphy_core::schema::{ExtractionOutput, Node};
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
fn cache_writes_v2_manifest_on_save() {
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
    assert!(body.contains("\"abi_version\": 2"));
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
