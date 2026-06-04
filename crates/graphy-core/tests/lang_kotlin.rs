//! Lang coverage: kotlin. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "kotlin";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/kotlin")
    );
    assert!(p.join("src/Service.kt").exists());
}

#[test]
fn types_emits_interface_node() {
    let out = extract_file(&fp("src/Types.kt"));
    assert_extract_has(&out, "Greeter", "interface");
}

#[test]
fn types_emits_data_and_sealed_class() {
    let out = extract_file(&fp("src/Types.kt"));
    assert_extract_has(&out, "State", "class");
    assert_extract_has(&out, "Result", "class");
}

#[test]
fn types_emits_object_declarations() {
    let out = extract_file(&fp("src/Types.kt"));
    assert_extract_has(&out, "Config", "object");
    assert_extract_has(&out, "Success", "object");
}

#[test]
fn helpers_emits_top_level_functions() {
    let out = extract_file(&fp("src/Helpers.kt"));
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelatedHelper", "function");
    assert_extract_has(&out, "toLoud", "function");
}

#[test]
fn helpers_emits_import() {
    let out = extract_file(&fp("src/Helpers.kt"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("Locale")),
        "java.util.Locale import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_emits_class() {
    let out = extract_file(&fp("src/Service.kt"));
    assert_extract_has(&out, "Service", "class");
}

#[test]
fn service_emits_imports_including_alias_and_star() {
    let out = extract_file(&fp("src/Service.kt"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| l.contains("LinkedHashMap")),
        "LinkedHashMap import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels
            .iter()
            .any(|l| l.contains("Collections") || l.contains("Col")),
        "aliased import not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| l.contains("kotlin.math")),
        "star import not seen; got {import_labels:?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_println() {
    let out = extract_file(&fp("src/Service.kt"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("println"))
        .collect();
    assert!(bad.is_empty(), "unexpected call edge to println: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/Empty.kt"));
    assert!(
        out.nodes.is_empty(),
        "Empty.kt produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.kt");
    std::fs::write(&p, "fun ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_kt_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.kt");
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
    let out = extract_file(&fp("src/Signatures.kt"));

    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1, "edges = {:#?}", out.edges); // n: Int is primitive
    assert_eq!(hp[0].target, "extern::Widget");
    let attr = hp[0].attr.as_ref().expect("attr");
    assert_eq!(attr.name.as_deref(), Some("widget"));
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
    assert_eq!(sig.params[0].name, "widget");
    assert_eq!(sig.params[0].ty.as_deref(), Some("Widget"));
    assert_eq!(sig.params[1].name, "n");
    assert_eq!(sig.params[1].ty.as_deref(), Some("Int"));
}

#[test]
fn order_param_index_counts_all_params() {
    let out = extract_file(&fp("src/Signatures.kt"));
    let hp = has_param_edges(&out, "::order");
    assert_eq!(hp.len(), 1); // only widget: Widget
    assert_eq!(hp[0].target, "extern::Widget");
    // n is index 0 (primitive, no edge); widget is the SECOND param.
    assert_eq!(hp[0].attr.as_ref().unwrap().index, Some(1));
}

#[test]
fn process_method_emits_has_param() {
    let out = extract_file(&fp("src/Signatures.kt"));
    let hp = has_param_edges(&out, "::process");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
    assert_eq!(hp[0].attr.as_ref().unwrap().name.as_deref(), Some("widget"));
}

#[test]
fn widget_emits_has_field_and_skips_primitive() {
    let out = extract_file(&fp("src/Signatures.kt"));

    // owner: Widget? -> has_field to extern::Widget
    let owner = out
        .edges
        .iter()
        .find(|e| {
            e.relation == "has_field"
                && e.source.ends_with("::Widget")
                && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("owner")
        })
        .expect("Widget.owner has_field");
    assert_eq!(owner.target, "extern::Widget");

    // label: String is primitive -> no has_field for it
    assert!(!out.edges.iter().any(|e| e.relation == "has_field"
        && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("label")));

    // Exclude extern:: nodes (those are type references, not the def node).
    let widget = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::Widget") && !n.id.starts_with("extern::"))
        .unwrap();
    let sig = widget.signature.as_ref().expect("class signature");
    let names: Vec<_> = sig.fields.iter().map(|f| f.name.as_str()).collect();
    assert_eq!(names, vec!["label", "owner"]);

    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("type") && n.id == "extern::Widget")
    );
}

#[test]
fn repo_store_emits_has_field() {
    let out = extract_file(&fp("src/Signatures.kt"));
    let store = out
        .edges
        .iter()
        .find(|e| {
            e.relation == "has_field"
                && e.source.ends_with("::Repo")
                && e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("store")
        })
        .expect("Repo.store has_field");
    assert_eq!(store.target, "extern::Widget");
}

// ---------- Generic inner types ----------

#[test]
fn generic_param_emits_inner_type_and_suppresses_container() {
    let out = extract_file(&fp("src/Signatures.kt"));
    let hp = has_param_edges(&out, "::generic");

    // items: List<Widget> -> exactly one edge, to Widget; List is suppressed.
    let items: Vec<_> = hp
        .iter()
        .filter(|e| e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("items"))
        .collect();
    assert_eq!(items.len(), 1, "edges = {:#?}", hp);
    assert_eq!(items[0].target, "extern::Widget");
    assert_eq!(items[0].attr.as_ref().unwrap().index, Some(0));
    assert!(!hp.iter().any(|e| e.target == "extern::List"));
    assert!(!out.nodes.iter().any(|n| n.id == "extern::List"));

    // pair: Pair<Foo, Bar> -> edges to Pair, Foo, Bar (Pair is a user generic),
    // all sharing the parameter index 1.
    let pair: Vec<_> = hp
        .iter()
        .filter(|e| e.attr.as_ref().and_then(|a| a.name.as_deref()) == Some("pair"))
        .collect();
    let targets: std::collections::HashSet<_> = pair.iter().map(|e| e.target.as_str()).collect();
    assert!(targets.contains("extern::Foo"), "targets = {targets:?}");
    assert!(targets.contains("extern::Bar"), "targets = {targets:?}");
    assert!(targets.contains("extern::Pair"), "targets = {targets:?}");
    assert!(
        pair.iter()
            .all(|e| e.attr.as_ref().unwrap().index == Some(1))
    );

    // Payload `ty` keeps the full generic text (only the EDGES resolve to inner types).
    let g = out
        .nodes
        .iter()
        .find(|n| n.id.ends_with("::generic"))
        .unwrap();
    let sig = g.signature.as_ref().expect("signature");
    assert_eq!(sig.params[0].name, "items");
    assert_eq!(sig.params[0].ty.as_deref(), Some("List<Widget>"));
    assert_eq!(sig.params[1].name, "pair");
    assert_eq!(sig.params[1].ty.as_deref(), Some("Pair<Foo, Bar>"));
}

#[test]
fn bare_type_param_still_one_edge() {
    // Regression: build(widget: Widget, n: Int) still emits exactly one has_param.
    let out = extract_file(&fp("src/Signatures.kt"));
    let hp = has_param_edges(&out, "::build");
    assert_eq!(hp.len(), 1);
    assert_eq!(hp[0].target, "extern::Widget");
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
fn pipeline_does_not_emit_local_call_to_println() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label.contains("println"))
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to println");
}
