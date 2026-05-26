//! Shared helpers for per-language coverage tests.
//!
//! Loaded via: `#[path = "lang_coverage/common.rs"] mod common;`

#![allow(dead_code)] // helpers used by some lang test binaries, not all

use std::path::{Path, PathBuf};

use graphy_core::extract::extract;
use graphy_core::graph::{KnowledgeGraph, NodeData};
use graphy_core::pipeline::{Pipeline, PipelineConfig};
use graphy_core::ExtractionOutput;
use tempfile::TempDir;

// ----- fixture helpers -----

pub fn fixture_dir(lang: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage")
        .join(lang)
}

// ----- extraction helpers -----

pub fn extract_file(path: &Path) -> ExtractionOutput {
    extract(path).unwrap_or_else(|e| panic!("extract failed for {}: {e}", path.display()))
}

pub fn assert_extract_has(out: &ExtractionOutput, label: &str, kind: &str) {
    let hit = out
        .nodes
        .iter()
        .any(|n| n.label == label && n.kind.as_deref() == Some(kind));
    if !hit {
        let dump: Vec<(String, Option<String>)> = out
            .nodes
            .iter()
            .map(|n| (n.label.clone(), n.kind.clone()))
            .collect();
        panic!(
            "assert_extract_has failed: expected label={label:?} kind={kind:?}, \
             extracted nodes = {dump:#?}"
        );
    }
}
