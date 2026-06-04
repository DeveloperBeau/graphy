//! Lang coverage: c. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "c";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(p.to_string_lossy().ends_with("fixtures/lang-coverage/c"));
    assert!(p.join("src/service.c").exists());
}

#[test]
fn types_h_emits_struct_and_enum() {
    let out = extract_file(&fp("src/types.h"));
    // struct Point, struct Service, enum State
    assert!(
        out.nodes
            .iter()
            .any(|n| n.label == "State" && n.kind.as_deref() == Some("enum")),
        "enum State not found; nodes={:#?}",
        out.nodes
    );
    assert!(
        out.nodes
            .iter()
            .any(|n| n.label == "Point" && n.kind.as_deref() == Some("struct")),
        "struct Point not found; nodes={:#?}",
        out.nodes
    );
}

#[test]
fn types_h_emits_system_include() {
    let out = extract_file(&fp("src/types.h"));
    assert_extract_has(&out, "stddef.h", "import");
}

#[test]
fn helpers_c_emits_functions() {
    let out = extract_file(&fp("src/helpers.c"));
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn helpers_c_emits_local_include() {
    let out = extract_file(&fp("src/helpers.c"));
    assert_extract_has(&out, "types.h", "import");
}

#[test]
fn service_c_emits_functions() {
    let out = extract_file(&fp("src/service.c"));
    assert_extract_has(&out, "service_new", "function");
    assert_extract_has(&out, "service_run", "function");
    assert_extract_has(&out, "service_free", "function");
}

#[test]
fn service_c_emits_system_and_local_includes() {
    let out = extract_file(&fp("src/service.c"));
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.contains(&"stdio.h"),
        "stdio.h not seen; got {import_labels:?}"
    );
    assert!(
        import_labels.contains(&"types.h"),
        "types.h not seen; got {import_labels:?}"
    );
}

#[test]
fn service_c_does_not_emit_call_to_external_printf() {
    let out = extract_file(&fp("src/service.c"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("printf"))
        .collect();
    assert!(bad.is_empty(), "unexpected call edge to printf: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.c"));
    assert!(
        out.nodes.is_empty(),
        "empty.c produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Typed-layer is C++-only (C unaffected) ----------

#[test]
fn c_emits_no_extern_type_edges() {
    // The typed signature layer (has_param / returns / has_field edges to
    // `extern::<Type>` nodes) is gated on the C++ flavor in the shared
    // extractor. Plain C — even with non-primitive `struct Service` params —
    // must emit none of it. Guards the generic-inner-type change from leaking
    // into C.
    let out = extract_file(&fp("src/service.c"));
    let typed: Vec<_> = out
        .edges
        .iter()
        .filter(|e| {
            matches!(e.relation.as_str(), "has_param" | "returns" | "has_field")
                && e.target.starts_with("extern::")
        })
        .collect();
    assert!(typed.is_empty(), "C emitted typed edges: {typed:#?}");
    assert!(
        !out.nodes.iter().any(|n| n.kind.as_deref() == Some("type")),
        "C emitted a type node"
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.c");
    std::fs::write(&p, "int ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_c_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.c");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let _ = graphy_core::extract::extract(&p);
}

// ---------- Tier 2: full pipeline ----------

use petgraph::visit::{EdgeRef, IntoEdgeReferences};

#[test]
fn pipeline_node_count_floor() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    const FLOOR: usize = 4;
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
fn pipeline_emits_at_least_one_imports_edge() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let has_import = g
        .graph
        .edge_references()
        .any(|e| e.weight().relation == "imports");
    assert!(has_import, "no imports edges in pipeline output");
}

#[test]
fn pipeline_does_not_emit_local_call_to_printf() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label == "printf")
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to printf");
}
