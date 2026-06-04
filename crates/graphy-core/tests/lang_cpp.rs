//! Lang coverage: cpp. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "cpp";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/cpp"));
    assert!(p.join("src/service.cpp").exists());
}

#[test]
fn types_hpp_emits_namespace() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "graphy", "namespace");
}

#[test]
fn types_hpp_emits_struct_and_class() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "Point", "struct");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn types_hpp_emits_system_include() {
    let out = extract_file(&fp("src/types.hpp"));
    assert_extract_has(&out, "string", "import");
}

#[test]
fn helpers_cpp_emits_namespace_and_functions() {
    let out = extract_file(&fp("src/helpers.cpp"));
    assert_extract_has(&out, "graphy", "namespace");
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn service_cpp_emits_namespace_class_functions() {
    let out = extract_file(&fp("src/service.cpp"));
    assert_extract_has(&out, "graphy", "namespace");
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "lookup", "function");
    assert_extract_has(&out, "run", "function");
}

#[test]
fn service_cpp_emits_includes() {
    let out = extract_file(&fp("src/service.cpp"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.contains(&"iostream"),
        "iostream not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.contains(&"types.hpp"),
        "types.hpp not seen; got {import_labels:?}"
    );
}

#[test]
fn service_cpp_does_not_emit_call_to_external_cout() {
    let out = extract_file(&fp("src/service.cpp"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("cout"))
        .collect();
    assert!(bad.is_empty(), "unexpected call edge to cout: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.cpp"));
    assert!(
        out.nodes.is_empty(),
        "empty.cpp produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.cpp");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_cpp_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.cpp");
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
fn build_emits_has_param_returns_and_payload() {
    let out = extract_file(&fp("src/signatures.cpp"));

    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges); // n int is primitive
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("w"));
    assert_eq!(attr.index, Some(0));

    assert!(out.edges.iter().any(|e| e.relation == "returns"
        && e.source.ends_with("::build")
        && e.target == "extern::Widget"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::build") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = build.signature.as_ref().expect("signature");
    assert_eq!(sig.returns.as_deref(), Some("Widget"));
    assert_eq!(sig.params.len(), 2);
    assert_eq!(sig.params[0].name, "w");
    assert_eq!(sig.params[0].ty.as_deref(), Some("Widget"));
    assert_eq!(sig.params[1].name, "n");
    assert_eq!(sig.params[1].ty.as_deref(), Some("int"));
}

#[test]
fn order_param_index_counts_all_params() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let hp = has_param_edges(&out, "::order");
    assert_eq!(hp.len(), 1); // only w: Widget
    assert_eq!(hp[0].target, "extern::Widget");
    // n is index 0 (primitive, no edge); w is the SECOND param.
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(1));
}

#[test]
fn method_process_emits_has_param() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let hp = has_param_edges(&out, "::process");
    assert_eq!(hp.len(), 1); // n primitive emits no edge
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().unwrap();
    assert_eq!(attr.name.as_deref(), Some("w"));
    assert_eq!(attr.index, Some(1));
}

#[test]
fn holder_emits_has_field() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let hf = out
        .edges
        .iter()
        .find(|e| e.relation == "has_field" && e.source.ends_with("::Holder"))
        .expect("Holder has_field");
    assert_eq!(hf.target, "extern::Widget");
    assert_eq!(hf.attr.as_ref().unwrap().name.as_deref(), Some("item"));
}

#[test]
fn primitive_param_has_no_edge() {
    let out = extract_file(&fp("src/signatures.cpp"));
    // build has two params (Widget w, int n); only the Widget gets an edge.
    assert_eq!(has_param_edges(&out, "::build").len(), 1);
}

#[test]
fn type_node_kind_exists() {
    let out = extract_file(&fp("src/signatures.cpp"));
    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("type") && n.id == "extern::Widget"),
        "no extern::Widget type node; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn build_signature_includes_primitive_param() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let build = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::build") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = build.signature.as_ref().expect("signature");
    // The primitive param carries its textual type in the payload.
    assert_eq!(sig.params[1].ty.as_deref(), Some("int"));
}

// ---------- Generic inner types ----------

#[test]
fn take_vec_resolves_to_inner_widget_container_suppressed() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let hp = has_param_edges(&out, "::take_vec");
    // The std::vector container is suppressed; only the inner Widget gets an edge.
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().name.as_deref(), Some("items"));
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(0));
    // Container itself must NOT produce an edge.
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::vector")
    );
    // std::string is a scalar stdlib type, not a user type: no edge.
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::string")
    );
    // Payload keeps the full textual type for every param, edge or not.
    let m = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::take_vec") && !n.id.starts_with("extern::"))
        .unwrap();
    let params = &m.signature.as_ref().unwrap().params;
    assert_eq!(params[0].ty.as_deref(), Some("std::vector<Widget>"));
    assert_eq!(params[1].ty.as_deref(), Some("std::string"));
}

#[test]
fn take_pair_emits_edges_to_base_and_both_inner_types() {
    let out = extract_file(&fp("src/signatures.cpp"));
    let hp = has_param_edges(&out, "::take_pair");
    // User generic Pair is NOT suppressed: Pair, Foo, Bar all get edges.
    assert_eq!(hp.len(), 3, "edges = {:#?}", out.edges);
    let targets: Vec<_> = hp.iter().map(|e| e.target.as_str()).collect();
    assert!(targets.contains(&"extern::Pair"), "got {targets:?}");
    assert!(targets.contains(&"extern::Foo"), "got {targets:?}");
    assert!(targets.contains(&"extern::Bar"), "got {targets:?}");
    // All three share the single param's index and name.
    for e in &hp {
        let attr = e.attr.as_ref().unwrap();
        assert_eq!(attr.index, Some(0));
        assert_eq!(attr.name.as_deref(), Some("p"));
    }
    // Payload keeps the full textual type.
    let m = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::take_pair") && !n.id.starts_with("extern::"))
        .unwrap();
    assert_eq!(
        m.signature
            .as_ref()
            .and_then(|s| s.params.first())
            .and_then(|p| p.ty.as_deref()),
        Some("Pair<Foo, Bar>")
    );
}

#[test]
fn bare_non_generic_param_still_one_edge() {
    // Regression guard: a non-generic param keeps exactly one edge after the
    // generic-inner change.
    let out = extract_file(&fp("src/signatures.cpp"));
    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
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
    assert_node(&g, "format_name", "function");
}

#[test]
fn pipeline_has_service_class() {
    // Anchor assertion: Service class must survive the pipeline.
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Service", "class");
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
fn pipeline_does_not_emit_local_call_to_cout() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("cout"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to cout");
}

#[test]
fn pipeline_deduplicates_namespace_to_single_node() {
    // The `graphy` namespace appears in types.hpp, helpers.cpp and service.cpp.
    // After dedup it must collapse to exactly one node (not marked ambiguous).
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let namespace_nodes: Vec<_> = g
        .graph
        .node_weights()
        .filter(|n| {
            n.label == "graphy"
                && n.kind
                    .as_deref()
                    .is_some_and(|k| k.starts_with("namespace"))
        })
        .collect();
    assert_eq!(
        namespace_nodes.len(),
        1,
        "expected exactly 1 'graphy' namespace node after dedup, got {}: {namespace_nodes:#?}",
        namespace_nodes.len()
    );
    let kind = namespace_nodes[0].kind.as_deref().unwrap_or("");
    assert!(
        !kind.contains("ambiguous"),
        "'graphy' namespace node is marked ambiguous: kind={kind:?}"
    );
}
