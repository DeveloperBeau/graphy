//! Lang coverage: csharp. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "csharp";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/csharp")
    );
    assert!(p.join("Service.cs").exists());
}

#[test]
fn types_emits_interface_enum_record_struct_class() {
    let out = extract_file(&fp("Types.cs"));
    assert_extract_has(&out, "IGreeter", "interface");
    assert_extract_has(&out, "State", "enum");
    assert_extract_has(&out, "Point", "record");
    assert_extract_has(&out, "Dimensions", "struct");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn types_emits_using_import() {
    let out = extract_file(&fp("Types.cs"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("System")),
        "System import not seen; got {import_labels:?}"
    );
}

#[test]
fn helpers_emits_class_and_methods() {
    let out = extract_file(&fp("Helpers.cs"));
    assert_extract_has(&out, "Helpers", "class");
    assert_extract_has(&out, "FormatName", "method");
    assert_extract_has(&out, "UnrelatedHelper", "method");
}

#[test]
fn helpers_emits_alias_using() {
    let out = extract_file(&fp("Helpers.cs"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // `using S = System.String;` -- alias form
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("System") || l.contains("S")),
        "alias using not seen; got {import_labels:?}"
    );
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("Service.cs"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "Hi", "method");
    assert_extract_has(&out, "Run", "method");
}

#[test]
fn service_emits_local_function() {
    let out = extract_file(&fp("Service.cs"));
    assert_extract_has(&out, "LocalLog", "method");
}

#[test]
fn service_emits_using_static() {
    let out = extract_file(&fp("Service.cs"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("Console") || l.contains("static")),
        "static using not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_writeline() {
    let out = extract_file(&fp("Service.cs"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("WriteLine"))
        .collect();
    assert!(
        bad.is_empty(),
        "unexpected call edge to WriteLine: {bad:#?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("Empty.cs"));
    assert!(
        out.nodes.is_empty(),
        "Empty.cs produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.cs");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_cs_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.cs");
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
    assert_node(&g, "FormatName", "method");
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
fn pipeline_does_not_emit_local_call_to_writeline() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| {
            e.weight().relation == "calls" && g.graph[e.target()].label.contains("WriteLine")
        })
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to WriteLine");
}
