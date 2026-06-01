//! Lang coverage: zig. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "zig";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/zig"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.zig").exists());
}

#[test]
fn helpers_emits_top_level_functions() {
    let out = extract_file(&fp("src/helpers.zig"));
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_emits_import_for_std() {
    let out = extract_file(&fp("src/service.zig"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.contains(&"std"),
        "std import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_import_for_local_helpers() {
    let out = extract_file(&fp("src/service.zig"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "helpers.zig import not found; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("types")),
        "types.zig import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_functions() {
    let out = extract_file(&fp("src/service.zig"));
    // init and run are struct methods emitted as functions via function_declaration
    let fn_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("function"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        !fn_labels.is_empty(),
        "no function nodes from service.zig; got {fn_labels:?}"
    );
}

#[test]
fn service_emits_calls_edge() {
    let out = extract_file(&fp("src/service.zig"));
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(
        !calls.is_empty(),
        "no calls edges from service.zig; edges = {:#?}",
        out.edges
    );
}

#[test]
fn types_emits_function_from_struct_method() {
    let out = extract_file(&fp("src/types.zig"));
    // distance is a struct method emitted as a function
    assert_extract_has(&out, "distance", "function");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.zig"));
    assert!(
        out.nodes.is_empty(),
        "empty.zig produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.zig produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.zig");
    std::fs::write(&p, "const x = @import(\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.zig");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_helpers_format_name() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
}

#[test]
fn pipeline_emits_at_least_one_import_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no import edges in pipeline output");
}

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 5;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}
