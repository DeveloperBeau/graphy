//! Lang coverage: python. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "python";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/python")
    );
    assert!(p.join("package/__init__.py").exists());
}

#[test]
fn types_emits_class_nodes() {
    let out = extract_file(&fp("package/types.py"));
    assert_extract_has(&out, "State", "class");
    assert_extract_has(&out, "Greet", "class");
}

#[test]
fn helpers_emits_top_level_functions() {
    let out = extract_file(&fp("package/helpers.py"));
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("package/service.py"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "run", "function");
    assert_extract_has(&out, "hi", "function");
}

#[test]
fn service_emits_inherits_edge_to_greet() {
    let out = extract_file(&fp("package/service.py"));
    let inherits: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "inherits")
        .collect();
    assert!(
        inherits
            .iter()
            .any(|e| e.source.ends_with("::Service") && e.target.ends_with("::Greet")),
        "missing inherits edge Service -> Greet; edges = {inherits:#?}"
    );
}

#[test]
fn service_emits_all_import_styles() {
    let out = extract_file(&fp("package/service.py"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // import collections.OrderedDict (single)
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("OrderedDict") || l.contains("collections")),
        "single import not seen; got {import_labels:?}"
    );
    // from os.path import join as path_join (aliased) - emits both canonical and alias
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("path_join") || l.contains("os.path")),
        "aliased import not seen; got {import_labels:?}"
    );
    // from .helpers import format_name (relative single)
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("format_name") || l.contains("helpers")),
        "relative single import not seen; got {import_labels:?}"
    );
    // from .types import * (star)
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("types") && l.contains("*")),
        "star import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_print() {
    // Anchor: verify call edges exist for known intra-file calls.
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("anchor.py");
    std::fs::write(&p, "def t():\n    pass\ndef caller():\n    t()\n").unwrap();
    let anchor = extract_file(&p);
    let anchor_calls: Vec<_> = anchor
        .edges
        .iter()
        .filter(|e| e.relation == "calls")
        .collect();
    assert!(
        !anchor_calls.is_empty(),
        "extractor emits no calls edges at all"
    );

    let out = extract_file(&fp("package/service.py"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let print_calls: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("print"))
        .collect();
    assert!(
        print_calls.is_empty(),
        "unexpected call edge to print: {print_calls:#?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("package/empty.py"));
    assert!(
        out.nodes.is_empty(),
        "empty.py produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.py produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.py");
    std::fs::write(&p, "def ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_py_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.py");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_emits_helpers_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "function");
}

#[test]
fn pipeline_emits_at_least_one_cross_file_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_does_not_emit_local_call_to_print() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("print"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to print");
}

#[test]
fn pipeline_preserves_inherits_edge_through_dedup() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_edge(&g, "Service", "Greet", "inherits");
}
