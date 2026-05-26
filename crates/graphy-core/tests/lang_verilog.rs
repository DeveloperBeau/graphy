//! Lang coverage: verilog. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Verilog is a hardware description language. The extractor emits `module`
//! and `function` nodes. `inherits`, `implements`, and `calls` are N/A.
//! The semantically interesting graph signal is module declarations, which
//! across files represent a hardware design hierarchy.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "verilog";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/verilog"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.v").exists());
}

#[test]
fn helpers_emits_module_nodes() {
    let out = extract_file(&fp("src/helpers.v"));
    let module_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("module"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        module_labels.iter().any(|l| *l == "adder"),
        "adder module not found; got {module_labels:?}"
    );
    assert!(
        module_labels.iter().any(|l| *l == "bit_and"),
        "bit_and module not found; got {module_labels:?}"
    );
}

#[test]
fn service_emits_counter_module() {
    let out = extract_file(&fp("src/service.v"));
    assert_extract_has(&out, "counter", "module");
}

#[test]
fn service_emits_top_module() {
    let out = extract_file(&fp("src/service.v"));
    assert_extract_has(&out, "top", "module");
}

#[test]
fn types_emits_constants_module() {
    let out = extract_file(&fp("src/types.v"));
    assert_extract_has(&out, "constants", "module");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.v"));
    assert!(out.nodes.is_empty(), "empty.v produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.v produced edges: {:#?}", out.edges);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.v");
    std::fs::write(&p, "module broken(input a\n// unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.v");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_resolves_adder_module() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "adder", "module");
}

#[test]
fn pipeline_resolves_counter_module() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "counter", "module");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 4;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_emits_no_inherits_or_implements_edges() {
    // Verilog has no inheritance or interface system in the extractor.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad: Vec<_> = g
        .graph
        .edge_references()
        .filter(|e| matches!(e.weight().relation.as_str(), "inherits" | "implements"))
        .collect();
    assert!(bad.is_empty(), "unexpected inherits/implements edges: {bad:#?}");
}
