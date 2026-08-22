//! Root canonicalization: one file must have exactly one node id.
//!
//! `set_current_dir` is process-global, so this file holds every test that
//! touches it and nothing else, keeping cargo's per-binary process isolation
//! from racing other test binaries.

use std::fs;

use graphy_core::{Pipeline, PipelineConfig};
use tempfile::tempdir;

#[test]
fn relative_and_absolute_roots_produce_identical_node_ids() {
    // `tempdir()` on macOS returns a path under a symlinked `/var/folders`,
    // while `std::env::current_dir()` after a `chdir` into it resolves to
    // the real `/private/var/...` form. `std::path::absolute` is lexical by
    // design (see pipeline.rs), so it does not paper over that gap — use
    // the canonical form on both sides here so the test isolates the
    // relative-vs-absolute property, not a tempdir/OS artifact.
    let dir = tempdir().unwrap();
    let root = dir.path().canonicalize().unwrap();
    fs::write(root.join("a.rs"), "pub fn f(){}\n").unwrap();

    let abs_out = tempdir().unwrap();
    let mut abs_cfg = PipelineConfig::new(&root);
    abs_cfg.out_root = abs_out.path().into();
    let abs_run = Pipeline::new(abs_cfg).run().unwrap();
    let mut abs_ids: Vec<String> = abs_run.graph.to_json_value()["nodes"]
        .as_array()
        .unwrap()
        .iter()
        .map(|n| n["id"].as_str().unwrap().to_string())
        .collect();
    abs_ids.sort();

    let rel_out = tempdir().unwrap();
    let prior_cwd = std::env::current_dir().unwrap();
    std::env::set_current_dir(&root).unwrap();
    let mut rel_cfg = PipelineConfig::new(".");
    rel_cfg.out_root = rel_out.path().into();
    let rel_run = Pipeline::new(rel_cfg).run().unwrap();
    std::env::set_current_dir(prior_cwd).unwrap();
    let mut rel_ids: Vec<String> = rel_run.graph.to_json_value()["nodes"]
        .as_array()
        .unwrap()
        .iter()
        .map(|n| n["id"].as_str().unwrap().to_string())
        .collect();
    rel_ids.sort();

    assert_eq!(abs_ids, rel_ids);
}

#[test]
fn node_ids_are_absolute_for_a_dot_root() {
    let dir = tempdir().unwrap();
    let root = dir.path().canonicalize().unwrap();
    fs::write(root.join("a.rs"), "pub fn f(){}\n").unwrap();
    let out = tempdir().unwrap();

    let prior_cwd = std::env::current_dir().unwrap();
    std::env::set_current_dir(&root).unwrap();
    let mut cfg = PipelineConfig::new(".");
    cfg.out_root = out.path().into();
    let run = Pipeline::new(cfg).run().unwrap();
    std::env::set_current_dir(prior_cwd).unwrap();

    let expected_prefix = root.to_string_lossy().into_owned();
    let ids: Vec<String> = run.graph.to_json_value()["nodes"]
        .as_array()
        .unwrap()
        .iter()
        .map(|n| n["id"].as_str().unwrap().to_string())
        .collect();
    assert!(!ids.is_empty());
    for id in ids {
        if id.starts_with("extern::") {
            continue;
        }
        assert!(
            id.starts_with(&expected_prefix),
            "id {id:?} does not start with absolute prefix {expected_prefix:?}"
        );
    }
}

// --- Fuzz: PipelineConfig::new over random path shapes ---
//
// xorshift64, no new dependency.
struct Xorshift64(u64);
impl Xorshift64 {
    fn next_u64(&mut self) -> u64 {
        let mut x = self.0;
        x ^= x << 13;
        x ^= x >> 7;
        x ^= x << 17;
        self.0 = x;
        x
    }
}

fn random_path(rng: &mut Xorshift64) -> String {
    const ALPHABET: &[&str] = &["a", "b", ".", "..", "", "c d", "e.f"];
    let literals = [".", "./", "a/"];
    // 1 in 8 chance of using a literal fixed case.
    if rng.next_u64().is_multiple_of(8) {
        return literals[(rng.next_u64() as usize) % literals.len()].to_string();
    }
    let n_components = (rng.next_u64() % 7) as usize; // 0..6
    let mut parts = Vec::with_capacity(n_components);
    for _ in 0..n_components {
        let idx = (rng.next_u64() as usize) % ALPHABET.len();
        parts.push(ALPHABET[idx]);
    }
    let mut s = parts.join("/");
    if rng.next_u64().is_multiple_of(2) {
        s = format!("/{s}");
    }
    s
}

#[test]
fn fuzz_pipeline_config_new_over_path_shapes() {
    let mut rng = Xorshift64(0x9E3779B97F4A7C15);
    for _ in 0..500 {
        let p = random_path(&mut rng);
        if p.is_empty() {
            continue;
        }
        let cfg = PipelineConfig::new(p.clone());
        assert!(
            cfg.root.is_absolute(),
            "PipelineConfig::new({p:?}).root = {:?} is not absolute",
            cfg.root
        );

        let cfg2 = PipelineConfig::new(cfg.root.clone());
        assert_eq!(
            cfg2.root, cfg.root,
            "idempotence failed for input {p:?}: {:?} -> {:?}",
            cfg.root, cfg2.root
        );

        assert_eq!(
            cfg.out_root, cfg.root,
            "out_root should default to root for input {p:?}"
        );
    }
}

#[test]
fn fuzz_empty_path_does_not_panic() {
    let cfg = PipelineConfig::new("");
    assert_eq!(cfg.root, std::path::PathBuf::from(""));
}
