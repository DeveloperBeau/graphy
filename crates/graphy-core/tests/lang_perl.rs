//! Lang coverage: perl. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "perl";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/perl"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("lib/Service.pm").exists());
}

#[test]
fn types_emits_package_and_use() {
    let out = extract_file(&fp("lib/Types.pm"));
    assert_extract_has(&out, "Types", "package");
    let has_strict = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("strict"));
    assert!(has_strict, "expected use strict import; nodes = {:#?}", out.nodes);
}

#[test]
fn types_emits_sub() {
    let out = extract_file(&fp("lib/Types.pm"));
    assert_extract_has(&out, "new", "sub");
}

#[test]
fn helpers_emits_package_and_subs() {
    let out = extract_file(&fp("lib/Helpers.pm"));
    assert_extract_has(&out, "Helpers", "package");
    assert_extract_has(&out, "format_name", "sub");
    assert_extract_has(&out, "unrelated_helper", "sub");
}

#[test]
fn service_emits_package_and_subs() {
    let out = extract_file(&fp("lib/Service.pm"));
    assert_extract_has(&out, "Service", "package");
    assert_extract_has(&out, "run", "sub");
    assert_extract_has(&out, "describe", "sub");
}

#[test]
fn service_emits_use_with_import_list() {
    let out = extract_file(&fp("lib/Service.pm"));
    let has_helpers_use = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("Helpers"));
    assert!(
        has_helpers_use,
        "expected use Helpers import; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn main_pl_emits_use_statements() {
    let out = extract_file(&fp("main.pl"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Service")),
        "use Service not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_module_emits_zero_nodes() {
    let out = extract_file(&fp("lib/Empty.pm"));
    // Empty.pm has just `1;` - no package/sub/use
    assert!(
        out.nodes.is_empty(),
        "empty.pm produced unexpected nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.pl");
    std::fs::write(&p, "sub (((( {\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_pl_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.pl");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_emits_package_and_sub_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Service", "package");
    assert_node(&g, "run", "sub");
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
    const FLOOR: usize = 6;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_helpers_format_name_present() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "format_name", "sub");
}
