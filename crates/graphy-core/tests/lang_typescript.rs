//! Lang coverage: typescript. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "typescript";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/typescript")
    );
    assert!(p.join("src/service.ts").exists());
}

#[test]
fn types_emits_interface() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "Greeter", "interface");
}

#[test]
fn types_emits_type_alias() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "UserId", "type_alias");
}

#[test]
fn types_emits_enum() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "State", "enum");
}

#[test]
fn types_emits_abstract_class() {
    let out = extract_file(&fp("src/types.ts"));
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn helpers_emits_typed_functions() {
    let out = extract_file(&fp("src/helpers.ts"));
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelatedHelper", "function");
}

#[test]
fn service_emits_class_and_methods() {
    let out = extract_file(&fp("src/service.ts"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "hi", "method");
    assert_extract_has(&out, "run", "method");
}

#[test]
fn service_emits_typed_imports() {
    let out = extract_file(&fp("src/service.ts"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("formatName")),
        "formatName import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("Greeter")),
        "Greeter import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_console_log() {
    let out = extract_file(&fp("src/service.ts"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("log"))
        .collect();
    assert!(
        bad.is_empty(),
        "unexpected call edge to console.log: {bad:#?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.ts"));
    assert!(
        out.nodes.is_empty(),
        "empty.ts produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.ts");
    std::fs::write(&p, "function ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_ts_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.ts");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Typed signature layer ----------

fn has_param_edges<'a>(
    out: &'a graphy_core::schema::ExtractionOutput,
    fn_suffix: &str,
) -> Vec<&'a graphy_core::schema::Edge> {
    out.edges
        .iter()
        .filter(|e| e.relation == "has_param" && e.source.ends_with(fn_suffix))
        .collect()
}

#[test]
fn build_emits_has_param_with_correct_index() {
    let out = extract_file(&fp("src/signatures.ts"));
    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges); // count: number is primitive
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("pet"));
    assert_eq!(attr.index, Some(1)); // counts the primitive count first
}

#[test]
fn build_emits_returns_edge() {
    let out = extract_file(&fp("src/signatures.ts"));
    assert!(out.edges.iter().any(|e| e.relation == "returns"
        && e.source.ends_with("::build")
        && e.target == "extern::Widget"));
}

#[test]
fn build_signature_payload_includes_both_params() {
    let out = extract_file(&fp("src/signatures.ts"));
    let build = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::build"))
        .unwrap();
    let sig = build.signature.as_ref().expect("signature");
    assert_eq!(sig.params.len(), 2);
    assert_eq!(sig.params[0].name, "count");
    assert_eq!(sig.params[0].ty.as_deref(), Some("number"));
    assert_eq!(sig.params[1].name, "pet");
    assert_eq!(sig.params[1].ty.as_deref(), Some("Widget"));
}

#[test]
fn build_signature_returns_is_bare_type() {
    let out = extract_file(&fp("src/signatures.ts"));
    let build = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::build"))
        .unwrap();
    assert_eq!(
        build.signature.as_ref().unwrap().returns.as_deref(),
        Some("Widget")
    );
}

#[test]
fn primitive_param_emits_no_type_edge() {
    let out = extract_file(&fp("src/signatures.ts"));
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::number")
    );
}

#[test]
fn method_process_emits_has_param() {
    let out = extract_file(&fp("src/signatures.ts"));
    let hp = has_param_edges(&out, "::process");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(
        hp[0].attr.as_ref().unwrap().name.as_deref(),
        Some("visitor")
    );
}

#[test]
fn class_field_emits_has_field() {
    let out = extract_file(&fp("src/signatures.ts"));
    let owner = out
        .edges
        .iter()
        .find(|e| e.relation == "has_field" && e.source.ends_with("::Widget"))
        .expect("Widget has_field");
    assert_eq!(owner.target, "extern::Person");
    assert_eq!(owner.attr.as_ref().unwrap().name.as_deref(), Some("owner"));

    assert!(out.edges.iter().any(|e| e.relation == "has_field"
        && e.source.ends_with("::Svc")
        && e.target == "extern::Widget"));
}

#[test]
fn interface_property_emits_has_field() {
    let out = extract_file(&fp("src/signatures.ts"));
    assert!(out.edges.iter().any(|e| e.relation == "has_field"
        && e.source.ends_with("::Shape")
        && e.target == "extern::Widget"
        && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("area")));
}

#[test]
fn primitive_field_emits_no_has_field() {
    let out = extract_file(&fp("src/signatures.ts"));
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_field" && e.target == "extern::string")
    );
}

#[test]
fn type_node_has_kind_type() {
    let out = extract_file(&fp("src/signatures.ts"));
    assert!(
        out.nodes
            .iter()
            .any(|n| n.id == "extern::Widget" && n.kind.as_deref() == Some("type"))
    );
}

#[test]
fn order_param_pet_index_is_zero() {
    let out = extract_file(&fp("src/signatures.ts"));
    let hp = has_param_edges(&out, "::order");
    assert_eq!(hp.len(), 1); // only pet: Widget
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(0));
}

#[test]
fn js_function_emits_no_typed_edges() {
    // JS has no type_annotation nodes, so the typed layer is a no-op: no
    // typed edges and the function node carries no signature.
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("s.js");
    std::fs::write(&p, "function build(count, pet) { return pet; }\n").unwrap();
    let out = extract_file(&p);
    assert!(
        !out.edges
            .iter()
            .any(|e| matches!(e.relation.as_str(), "has_param" | "has_field" | "returns"))
    );
    let build = out.nodes.iter().find(|n| n.label == "build").unwrap();
    assert!(build.signature.is_none());
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
fn pipeline_emits_interface_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Greeter", "interface");
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
fn pipeline_does_not_emit_local_call_to_log() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label == "log")
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to log");
}
