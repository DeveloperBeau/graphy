//! Lang coverage: swift. Tier 1 = per-file extract. Tier 2 = full pipeline.

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "swift";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    assert!(
        p.to_string_lossy()
            .ends_with("fixtures/lang-coverage/swift")
    );
    assert!(p.join("Sources/Service.swift").exists());
}

#[test]
fn types_emits_protocol_struct_enum_class() {
    let out = extract_file(&fp("Sources/Types.swift"));
    assert_extract_has(&out, "Greeter", "protocol");
    assert_extract_has(&out, "State", "enum");
    assert_extract_has(&out, "Point", "struct");
    assert_extract_has(&out, "BaseService", "class");
}

#[test]
fn types_emits_import() {
    let out = extract_file(&fp("Sources/Types.swift"));
    assert_extract_has(&out, "Foundation", "import");
}

#[test]
fn helpers_emits_functions() {
    let out = extract_file(&fp("Sources/Helpers.swift"));
    assert_extract_has(&out, "formatName", "function");
    assert_extract_has(&out, "unrelatedHelper", "function");
}

#[test]
fn service_emits_class_and_functions() {
    let out = extract_file(&fp("Sources/Service.swift"));
    assert_extract_has(&out, "Service", "class");
    assert_extract_has(&out, "hi", "function");
    assert_extract_has(&out, "run", "function");
}

#[test]
fn service_emits_init_and_deinit_as_functions() {
    let out = extract_file(&fp("Sources/Service.swift"));
    assert_extract_has(&out, "init", "function");
    assert_extract_has(&out, "deinit", "function");
}

#[test]
fn service_does_not_emit_call_to_external_print() {
    let out = extract_file(&fp("Sources/Service.swift"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    let bad: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("print"))
        .collect();
    assert!(bad.is_empty(), "unexpected call edge to print: {bad:#?}");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("Sources/Empty.swift"));
    assert!(
        out.nodes.is_empty(),
        "Empty.swift produced nodes: {:#?}",
        out.nodes
    );
}

// ---------- Edge cases ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.swift");
    std::fs::write(&p, "func ((( unterminated\n").unwrap();
    let _ = extract_file(&p);
}

#[test]
fn non_utf8_bytes_with_swift_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.swift");
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
fn pipeline_emits_format_name_function() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "formatName", "function");
}

#[test]
fn pipeline_emits_protocol_node() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    assert_node(&g, "Greeter", "protocol");
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
fn pipeline_does_not_emit_local_call_to_print() {
    let (g, _guard) = run_pipeline(&fixture_dir(LANG));
    let bad = g
        .graph
        .edge_references()
        .filter(|e| e.weight().relation == "calls" && g.graph[e.target()].label == "print")
        .count();
    assert_eq!(bad, 0, "unexpected pipeline call edge to print");
}
