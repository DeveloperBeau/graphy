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
    let inherits: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "inherits")
        .collect();
    assert!(
        inherits
            .iter()
            .any(|e| e.source.ends_with("::Service") && e.target.ends_with("::BaseService")),
        "missing inherits edge Service -> BaseService; edges = {inherits:#?}"
    );
    let implements: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "implements")
        .collect();
    assert!(
        implements
            .iter()
            .any(|e| e.source.ends_with("::Service") && e.target.ends_with("::Greeter")),
        "missing implements edge Service -> Greeter; edges = {implements:#?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_println() {
    let out = extract_file(&fp("src/com/example/Service.java"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("println"))
        .collect();
    assert!(bad.is_empty(), "unexpected call edge to println: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/com/example/Empty.java"));
    assert!(
        out.nodes.is_empty(),
        "Empty.java produced nodes: {:#?}",
        out.nodes
    );
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
    let out = extract_file(&fp("src/com/example/Signatures.java"));

    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges); // int n is primitive, no edge
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("w"));
    assert_eq!(attr.index, Some(0)); // w is first param in build(Widget w, int n)

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
    assert_eq!(sig.params[1].ty.as_deref(), Some("int")); // primitive in payload
}

#[test]
fn process_index_counts_all_params() {
    let out = extract_file(&fp("src/com/example/Signatures.java"));
    let hp = has_param_edges(&out, "::process");
    assert_eq!(hp.len(), 1); // only w: Widget; int n emits no edge
    assert_eq!(hp[0].target, "extern::Widget");
    // n is index 0 (primitive, no edge); w is SECOND param
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(1));
}

#[test]
fn process_primitive_param_emits_no_type_edge() {
    let out = extract_file(&fp("src/com/example/Signatures.java"));
    let bad: Vec<_> = out
        .edges
        .iter()
        .filter(|e| {
            e.relation == "has_param"
                && e.source.ends_with("::process")
                && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("n")
        })
        .collect();
    assert!(
        bad.is_empty(),
        "unexpected has_param edge for primitive param n: {bad:#?}"
    );
}

#[test]
fn class_emits_has_field_and_skips_primitive() {
    let out = extract_file(&fp("src/com/example/Signatures.java"));

    // Box.item: Widget -> has_field
    let field_edge = out
        .edges
        .iter()
        .find(|e| {
            e.relation == "has_field"
                && e.source.ends_with("::Box")
                && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("item")
        })
        .expect("Box has_field item");
    assert_eq!(field_edge.target, "extern::Widget");

    // Box.count: int -> no has_field edge
    assert!(!out.edges.iter().any(|e| e.relation == "has_field"
        && e.source.ends_with("::Box")
        && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("count")));

    // Box signature payload contains both fields
    let box_node = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Box") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = box_node.signature.as_ref().expect("Box signature");
    let names: Vec<_> = sig.fields.iter().map(|f| f.name.as_str()).collect();
    assert!(names.contains(&"item"), "item not in Box fields: {names:?}");
    assert!(
        names.contains(&"count"),
        "count not in Box fields: {names:?}"
    );
}

#[test]
fn collect_generic_param_resolves_to_inner_types() {
    let out = extract_file(&fp("src/com/example/Signatures.java"));

    // List<Widget>: container suppressed, edge to inner Widget at index 0.
    let widget: Vec<_> = has_param_edges(&out, "::collect")
        .into_iter()
        .filter(|e| e.target == "extern::Widget")
        .collect();
    assert_eq!(widget.len(), 1, "edges = {:#?}", out.edges);
    let attr = widget[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("items"));
    assert_eq!(attr.index, Some(0));

    // No edge to the List container itself.
    assert!(
        !out.edges
            .iter()
            .any(|e| e.relation == "has_param" && e.target == "extern::List"),
        "unexpected has_param edge to extern::List"
    );

    // Pair<Foo, Bar>: Pair is a user type (also gets an edge); Foo and Bar are
    // inner args. All three share the single per-parameter index 1.
    for ty in ["extern::Pair", "extern::Foo", "extern::Bar"] {
        let e = has_param_edges(&out, "::collect")
            .into_iter()
            .find(|e| e.target == ty)
            .unwrap_or_else(|| panic!("missing has_param edge to {ty}; edges = {:#?}", out.edges));
        let attr = e.attr.as_ref().expect("attr");
        assert_eq!(attr.name.as_deref(), Some("p"));
        assert_eq!(attr.index, Some(1), "{ty} index");
    }

    // Signature payload keeps the full textual type.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::collect"))
        .unwrap();
    let sig = collect.signature.as_ref().expect("signature");
    assert_eq!(sig.params[0].ty.as_deref(), Some("List<Widget>"));
    assert_eq!(sig.params[1].ty.as_deref(), Some("Pair<Foo, Bar>"));
}

#[test]
fn type_node_with_kind_type_is_emitted() {
    let out = extract_file(&fp("src/com/example/Signatures.java"));
    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("type") && n.id == "extern::Widget"),
        "no extern::Widget type node; nodes = {:#?}",
        out.nodes
    );
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
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
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
