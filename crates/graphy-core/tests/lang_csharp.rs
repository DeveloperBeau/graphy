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
    // Widget w at index 0; int n at index 1 is primitive -> no edge
    let out = extract_file(&fp("Signatures.cs"));
    let hp = has_param_edges(&out, "::Build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges);
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("w"));
    assert_eq!(attr.index, Some(0));

    assert!(out.edges.iter().any(|e| e.relation == "returns"
        && e.source.ends_with("::Build")
        && e.target == "extern::Widget"));

    let build = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Build"))
        .unwrap();
    let sig = build.signature.as_ref().expect("signature");
    assert_eq!(sig.returns.as_deref(), Some("Widget"));
    assert_eq!(sig.params.len(), 2);
    assert_eq!(sig.params[0].name, "w");
    assert_eq!(sig.params[0].ty.as_deref(), Some("Widget"));
    assert_eq!(sig.params[1].name, "n");
    assert_eq!(sig.params[1].ty.as_deref(), Some("int")); // payload present even for primitive
}

#[test]
fn order_param_index_counts_all_params() {
    // n (int, primitive) is index 0; w (Widget) is index 1 -> must assert index == 1
    let out = extract_file(&fp("Signatures.cs"));
    let hp = has_param_edges(&out, "::Order");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(1));
}

#[test]
fn process_emits_has_param() {
    // Requirement 2: method inside Svc class
    let out = extract_file(&fp("Signatures.cs"));
    let hp = has_param_edges(&out, "::Process");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().name.as_deref(), Some("input"));
}

#[test]
fn primitive_param_emits_no_type_edge() {
    // int n in Build/Order must not produce a has_param edge
    let out = extract_file(&fp("Signatures.cs"));
    let int_edges: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "has_param" && e.target == "extern::int")
        .collect();
    assert!(
        int_edges.is_empty(),
        "unexpected has_param to extern::int: {int_edges:#?}"
    );
}

#[test]
fn class_fields_emit_has_field_and_skip_primitives() {
    let out = extract_file(&fp("Signatures.cs"));

    // non-primitive property -> has_field
    let inner = out.edges.iter().find(|e| {
        e.relation == "has_field"
            && e.source.ends_with("::Widget")
            && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("Inner")
    });
    assert!(
        inner.is_some(),
        "Widget.Inner has_field edge missing; edges = {:#?}",
        out.edges
    );

    // primitive property -> no has_field
    assert!(!out.edges.iter().any(|e| e.relation == "has_field"
        && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("Label")));

    // non-primitive field_declaration -> has_field
    let owner = out.edges.iter().find(|e| {
        e.relation == "has_field"
            && e.source.ends_with("::Widget")
            && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("Owner")
    });
    assert!(
        owner.is_some(),
        "Widget.Owner has_field edge missing; edges = {:#?}",
        out.edges
    );

    // extern::Widget type node must exist
    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("type") && n.id == "extern::Widget")
    );

    // Widget def node has a non-empty fields signature
    let widget = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Widget") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = widget.signature.as_ref().expect("Widget struct signature");
    let names: Vec<_> = sig.fields.iter().map(|f| f.name.as_str()).collect();
    assert!(names.contains(&"Inner"), "fields = {names:?}");
    assert!(names.contains(&"Label"), "fields = {names:?}");
}

#[test]
fn collect_emits_generic_inner_type_edges() {
    // List<Widget>: container List suppressed, inner Widget gets the has_param edge.
    // Pair<Foo, Bar>: Pair (user generic) AND its inner Foo, Bar all get edges,
    // all sharing the param's index. Payload `ty` keeps the full textual type.
    let out = extract_file(&fp("Signatures.cs"));
    let hp = has_param_edges(&out, "::Collect");

    let targets: Vec<&str> = hp.iter().map(|e| e.target.as_str()).collect();
    assert!(targets.contains(&"extern::Widget"), "targets = {targets:?}");
    assert!(targets.contains(&"extern::Pair"), "targets = {targets:?}");
    assert!(targets.contains(&"extern::Foo"), "targets = {targets:?}");
    assert!(targets.contains(&"extern::Bar"), "targets = {targets:?}");

    // Suppressed container List must NOT produce an edge.
    assert!(
        !targets.contains(&"extern::List"),
        "List container leaked an edge: {targets:?}"
    );

    // items (index 0) -> Widget; pair (index 1) -> Pair, Foo, Bar all at index 1.
    let widget = hp
        .iter()
        .find(|e| e.target == "extern::Widget")
        .expect("Widget edge");
    assert_eq!(widget.attr.as_ref().unwrap().name.as_deref(), Some("items"));
    assert_eq!(widget.attr.as_ref().unwrap().index, Some(0));

    for t in ["extern::Pair", "extern::Foo", "extern::Bar"] {
        let e = hp.iter().find(|e| e.target == t).expect(t);
        assert_eq!(e.attr.as_ref().unwrap().name.as_deref(), Some("pair"));
        assert_eq!(e.attr.as_ref().unwrap().index, Some(1), "edge {t}");
    }

    // Payload `ty` keeps the full textual generic type, unchanged.
    let collect = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Collect"))
        .unwrap();
    let sig = collect.signature.as_ref().expect("signature");
    assert_eq!(sig.params[0].ty.as_deref(), Some("List<Widget>"));
    assert_eq!(sig.params[1].ty.as_deref(), Some("Pair<Foo, Bar>"));
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
