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
