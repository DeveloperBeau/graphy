//! Lang coverage: php. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "php";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/php"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("src/Types.php").exists());
}

#[test]
fn types_emits_interface_trait_enum() {
    let out = extract_file(&fp("src/Types.php"));
    assert_extract_has(&out, "Greet", "interface");
    assert_extract_has(&out, "Loggable", "trait");
    assert_extract_has(&out, "State", "enum");
}

#[test]
fn helpers_emits_class_and_functions() {
    let out = extract_file(&fp("src/Helpers.php"));
    assert_extract_has(&out, "Helpers", "class");
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/Service.php"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "run", "function");
    assert_extract_has(&out, "describe", "function");
}

#[test]
fn service_emits_use_imports() {
    let out = extract_file(&fp("src/Service.php"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "App\\Helpers import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Greet")),
        "App\\Greet import not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_no_user_nodes() {
    let out = extract_file(&fp("src/Empty.php"));
    // Empty.php has just `<?php` - no classes/functions
    let user_nodes: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| !matches!(n.kind.as_deref(), Some("import")))
        .collect();
    assert!(
        user_nodes.is_empty(),
        "empty.php produced unexpected nodes: {user_nodes:#?}"
    );
}

// ---------- Deferred follow-up: extends/implements inheritance edges ----------

#[test]
fn service_emits_implements_edge() {
    let out = extract_file(&fp("src/Service.php"));
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
    let p = dir.path().join("broken.php");
    std::fs::write(&p, "<?php\nclass ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_php_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.php");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_class_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Helpers", "class");
    assert_node(&g, "Service", "class");
}

#[test]
fn pipeline_emits_interface_and_trait() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Greet", "interface");
    assert_node(&g, "Loggable", "trait");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
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
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn intra_file_call_edge_emitted() {
    // Verify the PHP extractor emits a calls edge for a local (same-file) callee.
    // The extractor only emits calls when the callee resolves to a symbol defined in
    // the same file's symbol table. Use a minimal inline fixture to confirm.
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("calltest.php");
    std::fs::write(
        &p,
        "<?php\nfunction helper() {}\nfunction caller() { helper(); }\n",
    )
    .unwrap();
    let out = extract_file(&p);
    let has_calls = out.edges.iter().any(|e| e.relation == "calls");
    assert!(has_calls, "no calls edge for intra-file call; edges = {:#?}", out.edges);
}
