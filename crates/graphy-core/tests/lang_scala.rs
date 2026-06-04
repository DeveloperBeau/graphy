//! Lang coverage: scala. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "scala";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/scala"),
        "unexpected path: {}",
        p.display()
    );
    assert!(p.join("src/Types.scala").exists());
}

#[test]
fn types_emits_trait_and_classes() {
    let out = extract_file(&fp("src/Types.scala"));
    assert_extract_has(&out, "Greet", "trait");
    assert_extract_has(&out, "State", "class");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn types_emits_import() {
    let out = extract_file(&fp("src/Types.scala"));
    let has_import = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("scala.collection"));
    assert!(
        has_import,
        "expected import for scala.collection.mutable; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn helpers_emits_object_and_functions() {
    let out = extract_file(&fp("src/Helpers.scala"));
    assert_extract_has(&out, "Helpers", "object");
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelatedHelper", "function");
}

#[test]
fn helpers_emits_wildcard_import() {
    let out = extract_file(&fp("src/Helpers.scala"));
    let has_wildcard = out
        .nodes
        .iter()
        .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("_"));
    assert!(
        has_wildcard,
        "expected wildcard import (._); nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_object_class_and_functions() {
    let out = extract_file(&fp("src/Service.scala"));
    assert_extract_has(&out, "ServiceFactory", "object");
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "create", "function");
    assert_extract_has(&out, "run", "function");
    assert_extract_has(&out, "describe", "function");
}

#[test]
fn service_emits_multiple_import_styles() {
    let out = extract_file(&fp("src/Service.scala"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    // single qualified import
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("scala.collection.mutable.Map")),
        "single import not seen; got {import_labels:?}"
    );
    // renamed import with braces
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("List") || l.contains("CList")),
        "renamed import not seen; got {import_labels:?}"
    );
    // wildcard
    assert!(
        import_labels.iter().any(|l| l.contains("_")),
        "wildcard import not seen; got {import_labels:?}"
    );
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.scala"));
    assert!(
        out.nodes.is_empty(),
        "empty.scala produced nodes: {:#?}",
        out.nodes
    );
    assert!(
        out.edges.is_empty(),
        "empty.scala produced edges: {:#?}",
        out.edges
    );
}

// ---------- Deferred follow-up: extends/with inheritance edges ----------

#[test]
fn service_emits_inherits_edge_for_extends() {
    let out = extract_file(&fp("src/Service.scala"));
    // class Service extends BaseService with Greet => inherits edges
    let has_inherits = out
        .edges
        .iter()
        .any(|e| e.relation == "inherits" && e.target.contains("BaseService"));
    assert!(
        has_inherits,
        "expected inherits edge to BaseService; edges = {:#?}",
        out.edges
    );
}

#[test]
fn service_emits_inherits_edge_for_with() {
    let out = extract_file(&fp("src/Service.scala"));
    let has_with = out
        .edges
        .iter()
        .any(|e| e.relation == "inherits" && e.target.contains("Greet"));
    assert!(
        has_with,
        "expected inherits edge to Greet (with clause); edges = {:#?}",
        out.edges
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.scala");
    std::fs::write(&p, "class ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_scala_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.scala");
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
    let out = extract_file(&fp("src/Signatures.scala"));

    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges); // n: Int is primitive
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
        .find(|n| n.id.ends_with("::build"))
        .unwrap();
    let sig = build.signature.as_ref().expect("signature");
    assert_eq!(sig.returns.as_deref(), Some("Widget"));
    assert_eq!(sig.params.len(), 2);
    assert_eq!(sig.params[0].name, "w");
    assert_eq!(sig.params[0].ty.as_deref(), Some("Widget"));
    assert_eq!(sig.params[1].name, "n");
    assert_eq!(sig.params[1].ty.as_deref(), Some("Int")); // primitive: textual type in payload
}

#[test]
fn order_param_index_counts_all_params() {
    let out = extract_file(&fp("src/Signatures.scala"));
    let hp = has_param_edges(&out, "::order");
    assert_eq!(hp.len(), 1); // only w: Widget
    assert_eq!(hp[0].target, "extern::Widget");
    // n is index 0 (primitive, no edge); w is the SECOND param → index 1
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(1));
}

#[test]
fn method_process_emits_has_param() {
    let out = extract_file(&fp("src/Signatures.scala"));
    let hp = has_param_edges(&out, "::process");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().name.as_deref(), Some("w"));
}

#[test]
fn class_svc_emits_has_field_and_skips_primitive() {
    let out = extract_file(&fp("src/Signatures.scala"));

    // widget: Widget → has_field edge
    let f = out
        .edges
        .iter()
        .find(|e| e.relation == "has_field" && e.source.ends_with("::Svc"))
        .expect("Svc has_field");
    assert_eq!(f.target, "extern::Widget");
    assert_eq!(f.attr.as_ref().unwrap().name.as_deref(), Some("widget"));

    // count: Int is primitive → no has_field for it
    assert!(!out.edges.iter().any(|e| e.relation == "has_field"
        && e.source.ends_with("::Svc")
        && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("count")));

    // signature payload includes both fields
    let svc = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Svc") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = svc.signature.as_ref().expect("Svc signature");
    let names: Vec<_> = sig.fields.iter().map(|f| f.name.as_str()).collect();
    assert!(names.contains(&"widget"));
    assert!(names.contains(&"count"));
}

#[test]
fn type_node_kind_is_type() {
    let out = extract_file(&fp("src/Signatures.scala"));
    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("type") && n.id == "extern::Widget"),
        "no kind=type extern::Widget node; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn generic_param_emits_inner_type_and_suppresses_container() {
    let out = extract_file(&fp("src/Signatures.scala"));
    let hp = has_param_edges(&out, "::collect");
    // List is suppressed; only the inner Widget produces an edge.
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::List"),
        "List container should be suppressed; edges = {:#?}",
        out.edges
    );

    // signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::collect"))
        .unwrap();
    let sig = collect.signature.as_ref().expect("signature");
    assert_eq!(sig.params[0].ty.as_deref(), Some("List[Widget]"));
}

#[test]
fn two_arg_generic_emits_inner_types_and_keeps_user_container() {
    let out = extract_file(&fp("src/Signatures.scala"));
    let hp = has_param_edges(&out, "::pairUp");
    // Pair is a user type (kept) plus both inner args Foo and Bar => 3 edges.
    assert_eq!(hp.len(), 3, "edges = {:#?}", out.edges);
    let targets: Vec<_> = hp.iter().map(|e| e.target.as_str()).collect();
    assert!(targets.contains(&"extern::Pair"));
    assert!(targets.contains(&"extern::Foo"));
    assert!(targets.contains(&"extern::Bar"));
    // All three share the same param name and index.
    for e in &hp {
        let attr = e.attr.as_ref().expect("attr");
        assert_eq!(attr.name.as_deref(), Some("p"));
        assert_eq!(attr.index, Some(0));
    }

    let pair_up = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::pairUp"))
        .unwrap();
    let sig = pair_up.signature.as_ref().expect("signature");
    assert_eq!(sig.params[0].ty.as_deref(), Some("Pair[Foo, Bar]"));
}

#[test]
fn bare_type_param_still_one_edge() {
    let out = extract_file(&fp("src/Signatures.scala"));
    // bare Widget param on build emits exactly one edge.
    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
}

// ---------- Tier 2: full pipeline ----------

#[test]
fn pipeline_emits_object_and_class_nodes() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Helpers", "object");
    assert_node(&g, "Service", "class");
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
    const FLOOR: usize = 8;
    assert!(
        g.node_count() >= FLOOR,
        "node count {} below floor {FLOOR}",
        g.node_count()
    );
}

#[test]
fn pipeline_does_not_emit_call_to_extern_println() {
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("println"))
        .count();
    assert_eq!(bad, 0, "unexpected call edge to println");
}
