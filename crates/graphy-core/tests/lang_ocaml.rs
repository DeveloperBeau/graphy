//! Lang coverage: ocaml. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "ocaml";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/ocaml"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/service.ml").exists());
}

#[test]
fn types_emits_type_nodes() {
    let out = extract_file(&fp("src/types.ml"));
    assert_extract_has(&out, "id", "type");
    assert_extract_has(&out, "state", "type");
    assert_extract_has(&out, "service", "type");
}

#[test]
fn types_emits_module_type() {
    let out = extract_file(&fp("src/types.ml"));
    // module type Greet = sig ... end -> emitted as "module" kind
    assert_extract_has(&out, "Greet", "module");
}

#[test]
fn helpers_emits_value_nodes() {
    let out = extract_file(&fp("src/helpers.ml"));
    let value_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("value"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        value_labels.contains(&"format_name"),
        "format_name not found; got {value_labels:?}"
    );
    assert!(
        value_labels.contains(&"factorial"),
        "factorial not found; got {value_labels:?}"
    );
    assert!(
        value_labels.contains(&"unrelated_helper"),
        "unrelated_helper not found; got {value_labels:?}"
    );
}

#[test]
fn helpers_emits_module_node() {
    let out = extract_file(&fp("src/helpers.ml"));
    assert_extract_has(&out, "StringMap", "module");
}

#[test]
fn service_emits_open_import() {
    let out = extract_file(&fp("src/service.ml"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Types")),
        "Types import not found; got {import_labels:?}"
    );
}

#[test]
fn service_emits_module_node() {
    let out = extract_file(&fp("src/service.ml"));
    assert_extract_has(&out, "ServiceRegistry", "module");
}

#[test]
fn service_emits_value_nodes() {
    let out = extract_file(&fp("src/service.ml"));
    let value_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("value"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        value_labels
            .iter()
            .any(|l| *l == "max_retries" || *l == "make_service" || *l == "run_service"),
        "expected service values not found; got {value_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.ml"));
    assert!(
        out.nodes.is_empty(),
        "empty.ml produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.ml produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.ml");
    std::fs::write(&p, "let x = (((unclosed\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.ml");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_format_name_value() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has = g
        .graph
        .node_weights()
        .any(|n| n.label == "format_name" && n.kind.as_deref() == Some("value"));
    assert!(has, "format_name value node missing from pipeline graph");
}

#[test]
fn pipeline_emits_import_edges() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no import edges in pipeline output");
}

#[test]
fn pipeline_preserves_type_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "state", "type");
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
