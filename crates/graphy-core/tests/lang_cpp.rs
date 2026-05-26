//! Lang coverage: cpp. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "cpp";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/cpp"));
    assert!(p.join("src/service.cpp").exists());
}

#[test]
fn types_hpp_emits_namespace() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "graphy", "namespace");
}

#[test]
fn types_hpp_emits_struct_and_class() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "Point", "struct");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn types_hpp_emits_system_include() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "string", "import");
}

#[test]
fn helpers_cpp_emits_namespace_and_functions() {
    let out = extract_file(&fp("src/helpers.cpp"));
    assert_extract_has(&out, "graphy", "namespace");
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_cpp_emits_namespace_class_functions() {
    let out = extract_file(&fp("src/service.cpp"));
    assert_extract_has(&out, "graphy", "namespace");
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "lookup", "function");
    assert_extract_has(&out, "run", "function");
}

#[test]
fn service_cpp_emits_includes() {
    let out = extract_file(&fp("src/service.cpp"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| *l == "iostream"),
        "iostream not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| *l == "types.hpp"),
        "types.hpp not seen; got {import_labels:?}"
    );
}

#[test]
fn service_cpp_does_not_emit_call_to_external_cout() {
    let out = extract_file(&fp("src/service.cpp"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls.iter().filter(|e| e.target.contains("cout")).collect();
    assert!(bad.is_empty(), "unexpected call edge to cout: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.cpp"));
    assert!(out.nodes.is_empty(), "empty.cpp produced nodes: {:#?}", out.nodes);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.cpp");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_cpp_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.cpp");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

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

#[test]
fn pipeline_emits_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
}

#[test]
fn pipeline_has_service_class() {
    // Anchor assertion: Service class must survive the pipeline.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Service", "class");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g.graph.edge_references().any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_does_not_emit_local_call_to_cout() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("cout"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to cout");
}
