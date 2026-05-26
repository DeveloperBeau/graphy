//! Lang coverage: typescript. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "typescript";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/typescript"));
    assert!(p.join("src/service.ts").exists());
}

#[test]
fn types_emits_interface() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "Greeter", "interface");
}

#[test]
fn types_emits_type_alias() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "UserId", "type_alias");
}

#[test]
fn types_emits_enum() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "State", "enum");
}

#[test]
fn types_emits_abstract_class() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn helpers_emits_typed_functions() {
    let out = extract_file(&fp("src/helpers.ts"));
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelatedHelper", "function");
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/service.ts"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "hi", "method");
    assert_extract_has(&out, "run", "method");
}

#[test]
fn service_emits_typed_imports() {
    let out = extract_file(&fp("src/service.ts"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("formatName")),
        "formatName import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Greeter")),
        "Greeter import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_console_log() {
    let out = extract_file(&fp("src/service.ts"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls.iter().filter(|e| e.target.contains("log")).collect();
    assert!(bad.is_empty(), "unexpected call edge to console.log: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.ts"));
    assert!(out.nodes.is_empty(), "empty.ts produced nodes: {:#?}", out.nodes);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.ts");
    std::fs::write(&p, "function ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_ts_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.ts");
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
    assert_node(&g, "formatName", "function");
}

#[test]
fn pipeline_emits_interface_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Greeter", "interface");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g.graph.edge_references().any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_does_not_emit_local_call_to_log() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label == "log")
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to log");
}
