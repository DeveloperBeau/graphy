//! Lang coverage: go. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "go";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/go"));
    assert!(p.join("service.go").exists());
}

#[test]
fn types_emits_struct_and_interface() {
    let out = extract_file(&fp("types.go"));
    // Go extractor emits both struct and interface as kind=type
    assert_extract_has(&out, "Greeter", "type");
    assert_extract_has(&out, "State", "type");
}

#[test]
fn helpers_emits_top_level_functions() {
    let out = extract_file(&fp("helpers.go"));
    assert_extract_has(&out, "FormatName", "function");
    assert_extract_has(&out, "UnrelatedHelper", "function");
}

#[test]
fn helpers_emits_single_import() {
    let out = extract_file(&fp("helpers.go"));
    assert_extract_has(&out, "strings", "import");
}

#[test]
fn service_emits_type_and_functions() {
    let out = extract_file(&fp("service.go"));
    assert_extract_has(&out, "Service", "type");
    assert_extract_has(&out, "NewService", "function");
    assert_extract_has(&out, "Hi", "function");
    assert_extract_has(&out, "Run", "function");
}

#[test]
fn service_emits_grouped_and_aliased_imports() {
    let out = extract_file(&fp("service.go"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // grouped import: fmt, os
    assert!(
        import_labels.contains(&"fmt"),
        "fmt import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.contains(&"os"),
        "os import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_println() {
    let out = extract_file(&fp("service.go"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let println_calls: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("Println"))
        .collect();
    assert!(
        println_calls.is_empty(),
        "unexpected call edge to Println: {println_calls:#?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("empty.go"));
    assert!(
        out.nodes.is_empty(),
        "empty.go produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.go produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.go");
    std::fs::write(&p, "func ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_go_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.go");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 6;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_emits_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "FormatName", "function");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_does_not_emit_local_call_to_println() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("Println"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to Println");
}
