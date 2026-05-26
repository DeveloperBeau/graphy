//! Lang coverage: javascript. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "javascript";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/javascript"));
    assert!(p.join("src/service.js").exists());
}

#[test]
fn types_emits_classes_and_functions() {
    let out = extract_file(&fp("src/types.js"));
    assert_extract_has(&out, "State", "class");
    assert_extract_has(&out, "Greeter", "class");
    assert_extract_has(&out, "idGenerator", "function");
    assert_extract_has(&out, "fetchData", "function");
}

#[test]
fn helpers_emits_named_function() {
    let out = extract_file(&fp("src/helpers.js"));
    assert_extract_has(&out, "formatName", "function");
    // arrow function `unrelatedHelper` is not emitted as a named node
    // (const arrow functions are not `function_declaration`)
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/service.js"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "constructor", "method");
    assert_extract_has(&out, "hi", "method");
    assert_extract_has(&out, "run", "method");
}

#[test]
fn service_emits_named_default_namespace_aliased_imports() {
    let out = extract_file(&fp("src/service.js"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // named: `./helpers.js/formatName`
    assert!(
        import_labels.iter().any(|l| l.contains("formatName")),
        "named import formatName not seen; got {import_labels:?}"
    );
    // aliased: `./types.js/AppState` (import { State as AppState })
    assert!(
        import_labels.iter().any(|l| l.contains("AppState") || l.contains("State")),
        "aliased import AppState/State not seen; got {import_labels:?}"
    );
    // namespace: `./helpers.js/*`
    assert!(
        import_labels.iter().any(|l| l.contains("helpers") && l.contains("*")),
        "namespace import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_console_log() {
    let out = extract_file(&fp("src/service.js"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls.iter().filter(|e| e.target.contains("log")).collect();
    assert!(bad.is_empty(), "unexpected call edge to console.log: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.js"));
    assert!(out.nodes.is_empty(), "empty.js produced nodes: {:#?}", out.nodes);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.js");
    std::fs::write(&p, "function ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_js_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.js");
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
