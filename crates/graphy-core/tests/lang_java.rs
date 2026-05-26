//! Lang coverage: java. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "java";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/java"));
    assert!(p.join("src/com/example/Service.java").exists());
}

#[test]
fn types_emits_interface_enum_record_class() {
    let out = extract_file(&fp("src/com/example/Types.java"));
    assert_extract_has(&out, "Greeter", "interface");
    assert_extract_has(&out, "State", "enum");
    assert_extract_has(&out, "Point", "record");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn helpers_emits_class_and_methods() {
    let out = extract_file(&fp("src/com/example/Helpers.java"));
    assert_extract_has(&out, "Helpers", "class");
    assert_extract_has(&out, "formatName", "method");
    assert_extract_has(&out, "unrelatedHelper", "method");
}

#[test]
fn helpers_emits_import() {
    let out = extract_file(&fp("src/com/example/Helpers.java"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Locale")),
        "Locale import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/com/example/Service.java"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "hi", "method");
    assert_extract_has(&out, "run", "method");
}

#[test]
fn service_emits_all_import_styles() {
    let out = extract_file(&fp("src/com/example/Service.java"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // single import
    assert!(
        import_labels.iter().any(|l| l.contains("HashMap")),
        "HashMap import not seen; got {import_labels:?}"
    );
    // wildcard import
    assert!(
        import_labels.iter().any(|l| l.contains("java.util.*")),
        "wildcard import not seen; got {import_labels:?}"
    );
    // static import
    assert!(
        import_labels.iter().any(|l| l.contains("static")),
        "static import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_emits_inherits_and_implements_edges() {
    let out = extract_file(&fp("src/com/example/Service.java"));
    let inherits: Vec<_> = out.edges.iter().filter(|e| e.relation == "inherits").collect();
    assert!(
        inherits.iter().any(|e| e.source.ends_with("::Service") && e.target.ends_with("::BaseService")),
        "missing inherits edge Service -> BaseService; edges = {inherits:#?}"
    );
    let implements: Vec<_> = out.edges.iter().filter(|e| e.relation == "implements").collect();
    assert!(
        implements.iter().any(|e| e.source.ends_with("::Service") && e.target.ends_with("::Greeter")),
        "missing implements edge Service -> Greeter; edges = {implements:#?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_println() {
    let out = extract_file(&fp("src/com/example/Service.java"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls.iter().filter(|e| e.target.contains("println")).collect();
    assert!(bad.is_empty(), "unexpected call edge to println: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/com/example/Empty.java"));
    assert!(out.nodes.is_empty(), "Empty.java produced nodes: {:#?}", out.nodes);
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.java");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_java_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.java");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

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
fn pipeline_emits_format_name_method() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "formatName", "method");
}

#[test]
fn pipeline_emits_at_least_one_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g.graph.edge_references().any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_preserves_inherits_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_edge(&g, "Service", "BaseService", "inherits");
}

#[test]
fn pipeline_preserves_implements_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_edge(&g, "Service", "Greeter", "implements");
}

#[test]
fn pipeline_does_not_emit_local_call_to_println() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("println"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to println");
}
