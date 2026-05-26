//! Shared helpers for per-language coverage tests.
//!
//! Loaded via: `#[path = "lang_coverage/common.rs"] mod common;`

#![allow(dead_code)] // helpers used by some lang test binaries, not all

use std::path::{Path, PathBuf};

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

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

// ----- pipeline helpers -----

/// Run the full pipeline on `root` with hermetic output, no cache, no
/// incremental fast-path. Returns the in-memory graph plus the tempdir
/// guard the caller must keep alive for the duration of the test.
pub fn run_pipeline(root: &Path) -> (KnowledgeGraph, TempDir) {
    let tmp = TempDir::new().expect("create tempdir for pipeline out_root");
    let cfg = PipelineConfig {
        root: root.to_path_buf(),
        out_root: tmp.path().to_path_buf(),
        include_docs: false,
        use_cache: false,
        dedup: true,
        incremental: false,
        scc_expansion: true,
        hierarchical_clustering: true,
    };
    let out = Pipeline::new(cfg)
        .run()
        .unwrap_or_else(|e| panic!("pipeline failed for {}: {e}", root.display()));
    (out.graph, tmp)
}

// ----- extraction edge helpers (internal) -----

fn id_for_label(out: &ExtractionOutput, label: &str) -> Option<String> {
    out.nodes.iter().find(|n| n.label == label).map(|n| n.id.clone())
}

pub fn assert_extract_edge(out: &ExtractionOutput, relation: &str, src_label: &str, dst_label: &str) {
    let src_id = id_for_label(out, src_label);
    let dst_id = id_for_label(out, dst_label);
    let hit = if let (Some(s), Some(d)) = (src_id.as_ref(), dst_id.as_ref()) {
        out.edges
            .iter()
            .any(|e| e.relation == relation && &e.source == s && &e.target == d)
    } else {
        false
    };
    if !hit {
        let edge_dump: Vec<(String, String, String)> = out
            .edges
            .iter()
            .map(|e| (e.relation.clone(), e.source.clone(), e.target.clone()))
            .collect();
        panic!(
            "assert_extract_edge failed: relation={relation:?} src_label={src_label:?} \
             dst_label={dst_label:?} (src_id={src_id:?}, dst_id={dst_id:?}); \
             extracted edges = {edge_dump:#?}"
        );
    }
}

// ----- graph-level assertion helpers -----

pub fn find_node<'a>(g: &'a KnowledgeGraph, label: &str) -> Option<&'a NodeData> {
    g.graph.node_weights().find(|n| n.label == label)
}

pub fn assert_node(g: &KnowledgeGraph, label: &str, kind: &str) {
    let hit = g
        .graph
        .node_weights()
        .any(|n| n.label == label && n.kind.as_deref() == Some(kind));
    if !hit {
        let dump: Vec<(String, Option<String>)> = g
            .graph
            .node_weights()
            .map(|n| (n.label.clone(), n.kind.clone()))
            .collect();
        panic!(
            "assert_node failed: expected label={label:?} kind={kind:?}, \
             graph nodes = {dump:#?}"
        );
    }
}

fn node_id_for_label(g: &KnowledgeGraph, label: &str) -> Option<petgraph::graph::NodeIndex> {
    g.graph
        .node_indices()
        .find(|i| g.graph[*i].label == label)
}

pub fn assert_edge(g: &KnowledgeGraph, src_label: &str, dst_label: &str, relation: &str) {
    let src = node_id_for_label(g, src_label);
    let dst = node_id_for_label(g, dst_label);
    let hit = if let (Some(s), Some(d)) = (src, dst) {
        g.graph
            .edges_connecting(s, d)
            .any(|e| e.weight().relation == relation)
    } else {
        false
    };
    if !hit {
        let edges: Vec<(String, String, String)> = g
            .graph
            .edge_references()
            .map(|e| (
                g.graph[e.source()].label.clone(),
                g.graph[e.target()].label.clone(),
                e.weight().relation.clone(),
            ))
            .collect();
        panic!(
            "assert_edge failed: src={src_label:?} dst={dst_label:?} relation={relation:?}; \
             graph edges = {edges:#?}"
        );
    }
}

pub fn assert_no_edge(g: &KnowledgeGraph, src_label: &str, dst_label: &str) {
    let src = node_id_for_label(g, src_label);
    let dst = node_id_for_label(g, dst_label);
    if let (Some(s), Some(d)) = (src, dst) {
        let any = g.graph.edges_connecting(s, d).next().is_some();
        if any {
            let edges: Vec<String> = g
                .graph
                .edges_connecting(s, d)
                .map(|e| e.weight().relation.clone())
                .collect();
            panic!(
                "assert_no_edge failed: src={src_label:?} dst={dst_label:?}; \
                 unexpected edges present with relations {edges:?}"
            );
        }
    }
}
