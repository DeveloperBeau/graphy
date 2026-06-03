//! Lang coverage: ruby. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "ruby";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/ruby"));
    assert!(p.join("lib/service.rb").exists());
}

#[test]
fn types_emits_class_and_module() {
    let out = extract_file(&fp("lib/types.rb"));
    assert_extract_has(&out, "Greetable", "module");
    assert_extract_has(&out, "State", "class");
}

#[test]
fn helpers_emits_module_and_methods() {
    let out = extract_file(&fp("lib/helpers.rb"));
    assert_extract_has(&out, "Helpers", "module");
    assert_extract_has(&out, "format_name", "method");
    assert_extract_has(&out, "unrelated_helper", "method");
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("lib/service.rb"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "initialize", "method");
    assert_extract_has(&out, "run", "method");
    assert_extract_has(&out, "hi", "method");
}

#[test]
fn service_emits_require_imports() {
    let out = extract_file(&fp("lib/service.rb"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // require "json"
    assert!(
        import_labels.contains(&"json"),
        "json import not seen; got {import_labels:?}"
    );
    // require_relative "helpers"
    assert!(
        import_labels.contains(&"helpers"),
        "helpers import not seen; got {import_labels:?}"
    );
    // require_relative "types"
    assert!(
        import_labels.contains(&"types"),
        "types import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_puts() {
    let out = extract_file(&fp("lib/service.rb"));
    // Anchor: the extractor does emit call edges for resolved symbols.
    // The `run` method calls Helpers.format_name which is not locally resolved,
    // so calls may be empty. We just assert puts is absent.
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let puts_calls: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("puts"))
        .collect();
    assert!(
        puts_calls.is_empty(),
        "unexpected call edge to puts: {puts_calls:#?}"
    );
}

// ---------- Tier 1: typed signature layer (NAME-ONLY) ----------

#[test]
fn signatures_capture_param_names_with_null_type() {
    let out = extract_file(&fp("lib/signatures.rb"));

    // Module-level function `deliver` carries its parameter names, ty absent.
    let deliver = out
        .nodes
        .iter()
        .find(|n| n.label == "deliver")
        .expect("deliver node");
    let sig = deliver.signature.as_ref().expect("deliver signature");
    let names: Vec<&str> = sig.params.iter().map(|p| p.name.as_str()).collect();
    assert_eq!(names, vec!["recipient", "subject", "attachments"]);
    assert!(
        sig.params.iter().all(|p| p.ty.is_none()),
        "NAME-ONLY: every param ty must be None, got {:#?}",
        sig.params
    );
    assert!(sig.returns.is_none(), "NAME-ONLY: returns must be None");
    assert!(sig.fields.is_empty(), "NAME-ONLY: fields must be empty");

    // Instance method `archive` likewise.
    let archive = out
        .nodes
        .iter()
        .find(|n| n.label == "archive")
        .expect("archive node");
    let asig = archive.signature.as_ref().expect("archive signature");
    let anames: Vec<&str> = asig.params.iter().map(|p| p.name.as_str()).collect();
    assert_eq!(anames, vec!["message", "folder"]);
    assert!(asig.params.iter().all(|p| p.ty.is_none()));
}

#[test]
fn signatures_emit_no_typed_edges_or_type_nodes() {
    let out = extract_file(&fp("lib/signatures.rb"));

    for rel in ["has_param", "returns", "has_field"] {
        let count = out.edges.iter().filter(|e| e.relation == rel).count();
        assert_eq!(
            count, 0,
            "NAME-ONLY: expected zero {rel} edges, got {count}"
        );
    }
    let type_nodes = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("type"))
        .count();
    assert_eq!(
        type_nodes, 0,
        "NAME-ONLY: expected zero kind:type nodes, got {type_nodes}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("lib/empty.rb"));
    assert!(
        out.nodes.is_empty(),
        "empty.rb produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.rb produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.rb");
    std::fs::write(&p, "def ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_rb_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.rb");
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
fn pipeline_emits_format_name_method() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "method");
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
fn pipeline_does_not_emit_local_call_to_puts() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label == "puts")
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to puts");
}
