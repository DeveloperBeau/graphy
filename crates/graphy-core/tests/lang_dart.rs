//! Lang coverage: dart. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "dart";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/dart"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("lib/service.dart").exists());
}

#[test]
fn types_emits_mixin_and_enum() {
    let out = extract_file(&fp("lib/types.dart"));
    // abstract class Greet is not extracted as a class node (no class_definition for abstract class)
    // mixin Loggable and enum State are extracted
    assert_extract_has(&out, "Loggable", "mixin");
    assert_extract_has(&out, "State", "enum");
}

#[test]
fn types_emits_function_from_abstract() {
    // hi() method inside abstract class Greet is extracted as a function
    let out = extract_file(&fp("lib/types.dart"));
    let has_fn = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("function") && n.label == "hi");
    assert!(
        has_fn,
        "expected hi function inside abstract class; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn types_emits_import() {
    let out = extract_file(&fp("lib/types.dart"));
    let has_import = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("dart:core"));
    assert!(
        has_import,
        "expected dart:core import; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn helpers_emits_class_and_extension() {
    let out = extract_file(&fp("lib/helpers.dart"));
    assert_extract_has(&out, "StringExtension", "extension");
}

#[test]
fn helpers_emits_functions() {
    let out = extract_file(&fp("lib/helpers.dart"));
    let has_fn = out.nodes.iter().any(|n| {
        n.kind.as_deref() == Some("function")
            && (n.label == "formatName" || n.label == "unrelatedHelper")
    });
    assert!(
        has_fn,
        "expected formatName or unrelatedHelper function; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_functions() {
    let out = extract_file(&fp("lib/service.dart"));
    assert_extract_has(&out, "run", "function");
    assert_extract_has(&out, "describe", "function");
    assert_extract_has(&out, "topLevelHelper", "function");
}

#[test]
fn service_emits_import_styles() {
    let out = extract_file(&fp("lib/service.dart"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // dart:io basic import
    assert!(
        import_labels.iter().any(|l| l.contains("dart:io")),
        "dart:io import not seen; got {import_labels:?}"
    );
    // show import
    assert!(
        import_labels.iter().any(|l| l.contains("helpers")),
        "helpers.dart show import not seen; got {import_labels:?}"
    );
    // as import
    assert!(
        import_labels.iter().any(|l| l.contains("types")),
        "types.dart as import not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("lib/empty.dart"));
    assert!(
        out.nodes.is_empty(),
        "empty.dart produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.dart produced edges: {:#?}",
        out.edges
    );
}

// ---------- Deferred follow-up: implements inheritance edges ----------

#[test]
fn service_emits_implements_edge() {
    let out = extract_file(&fp("lib/service.dart"));
    // class Service implements Greet
    let has_implements = out
        .edges
        .iter()
        .any(|e| e.relation == "implements" && e.target.contains("Greet"));
    assert!(
        has_implements,
        "expected implements edge to Greet; edges = {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.dart");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_dart_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.dart");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

#[test]
fn pipeline_emits_mixin_and_enum() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Loggable", "mixin");
    assert_node(&g, "State", "enum");
}

#[test]
fn pipeline_emits_extension_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "StringExtension", "extension");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    use petgraph::visit::IntoEdgeReferences;
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_imports = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_imports, "no imports edges in pipeline output");
}

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
