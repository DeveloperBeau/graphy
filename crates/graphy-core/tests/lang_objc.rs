//! Lang coverage: objc. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "objc";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy().ends_with("fixtures/lang-coverage/objc"),
        "unexpected fixture path: {}",
        p.display()
    );
    assert!(p.join("src/Service.m").exists());
}

#[test]
fn service_m_emits_class_node() {
    let out = extract_file(&fp("src/Service.m"));
    assert_extract_has(&out, "Service", "class");
}

#[test]
fn service_m_emits_method_nodes() {
    let out = extract_file(&fp("src/Service.m"));
    let method_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("method"))
        .map(|n| n.label.as_str())
        .collect();
    // Should find run, greeting, shared, initWithName
    assert!(
        method_labels.contains(&"run"),
        "method 'run' not found; got {method_labels:?}"
    );
    assert!(
        method_labels.contains(&"greeting"),
        "method 'greeting' not found; got {method_labels:?}"
    );
}

#[test]
fn service_m_emits_import_for_header() {
    let out = extract_file(&fp("src/Service.m"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Service")),
        "Service.h import not found; got {import_labels:?}"
    );
}

#[test]
fn helpers_m_emits_class_and_methods() {
    let out = extract_file(&fp("src/Helpers.m"));
    assert_extract_has(&out, "Helpers", "class");
    let method_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("method"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        method_labels.contains(&"formatName"),
        "method 'formatName' not found; got {method_labels:?}"
    );
}

#[test]
fn helpers_m_emits_import_for_helpers_header() {
    let out = extract_file(&fp("src/Helpers.m"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Helpers")),
        "Helpers.h import not found; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.m"));
    assert!(
        out.nodes.is_empty(),
        "Empty.m produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "Empty.m produced edges: {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.m");
    std::fs::write(&p, "@interface ((( broken\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.m");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Deferred closure: .h header file extraction ----------

#[test]
fn service_h_emits_class_node() {
    let out = extract_file(&fp("src/Service.h"));
    assert_extract_has(&out, "Service", "class");
}

#[test]
fn service_h_emits_method_nodes() {
    let out = extract_file(&fp("src/Service.h"));
    let method_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("method"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        method_labels.contains(&"run"),
        "method 'run' from Service.h not found; got {method_labels:?}"
    );
}

#[test]
fn helpers_h_emits_class_node() {
    let out = extract_file(&fp("src/Helpers.h"));
    assert_extract_has(&out, "Helpers", "class");
}

#[test]
fn helpers_h_emits_method_nodes() {
    let out = extract_file(&fp("src/Helpers.h"));
    let method_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("method"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        method_labels.contains(&"formatName"),
        "method 'formatName' from Helpers.h not found; got {method_labels:?}"
    );
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::IntoEdgeReferences;

#[test]
fn pipeline_resolves_service_class() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // After dedup a label appearing in both .h and .m gets "class?ambiguous"; match by prefix.
    let has = g.graph.node_weights().any(|n| {
        n.label == "Service"
            && n.kind
                .as_deref()
                .map(|k| k.starts_with("class"))
                .unwrap_or(false)
    });
    assert!(
        has,
        "Service class node missing from pipeline graph; nodes = {:#?}",
        g.graph
            .node_weights()
            .map(|n| (&n.label, &n.kind))
            .collect::<Vec<_>>()
    );
}

#[test]
fn pipeline_resolves_helpers_class() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    // After dedup a label appearing in both .h and .m gets "class?ambiguous"; match by prefix.
    let has = g.graph.node_weights().any(|n| {
        n.label == "Helpers"
            && n.kind
                .as_deref()
                .map(|k| k.starts_with("class"))
                .unwrap_or(false)
    });
    assert!(
        has,
        "Helpers class node missing from pipeline graph; nodes = {:#?}",
        g.graph
            .node_weights()
            .map(|n| (&n.label, &n.kind))
            .collect::<Vec<_>>()
    );
}

#[test]
fn pipeline_emits_at_least_one_import_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no import edges in pipeline output");
}

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
