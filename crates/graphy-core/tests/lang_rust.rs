//! Lang coverage: rust. Tier 1 = per-file extract. Tier 2 = full pipeline.
//!
//! Spec: docs/superpowers/specs/2026-05-26-lang-coverage-design.md

#[path = "lang_coverage/common.rs"]
mod common;

use common::*;

const LANG: &str = "rust";

fn fp(rel: &str) -> std::path::PathBuf {
    fixture_dir(LANG).join(rel)
}

// ---------- Tier 1: per-file extract ----------

#[test]
fn lib_emits_mod_nodes_for_each_submodule() {
    let out = extract_file(&fp("src/lib.rs"));
    assert_extract_has(&out, "helpers", "mod");
    assert_extract_has(&out, "service", "mod");
    assert_extract_has(&out, "types", "mod");
}

#[test]
fn lib_emits_glob_import_node_for_re_export() {
    let out = extract_file(&fp("src/lib.rs"));
    // `pub use crate::types::*;` -> import node labelled with the path
    assert!(
        out.nodes
            .iter()
            .any(|n| n.kind.as_deref() == Some("import") && n.label.contains("types")),
        "no glob re-export import seen; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn lib_emits_entry_function() {
    let out = extract_file(&fp("src/lib.rs"));
    assert_extract_has(&out, "entry", "function");
}

#[test]
fn service_emits_struct() {
    let out = extract_file(&fp("src/service.rs"));
    assert_extract_has(&out, "Service", "struct");
}

#[test]
fn service_emits_single_qualified_import() {
    let out = extract_file(&fp("src/service.rs"));
    // `use std::collections::HashMap;`
    assert!(
        out.nodes.iter().any(|n| n.kind.as_deref() == Some("import")
            && n.label.contains("std::collections::HashMap")),
        "missing HashMap import; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_braced_imports_expanded() {
    let out = extract_file(&fp("src/service.rs"));
    // `use crate::types::{Greet, State, UserId};`
    let needles = ["Greet", "State", "UserId"];
    for n in needles {
        assert!(
            out.nodes.iter().any(|node| node.kind.as_deref() == Some("import")
                && node.label.contains(&format!("types::{n}"))),
            "missing braced import for {n}; nodes = {:#?}",
            out.nodes
        );
    }
}

#[test]
fn service_emits_aliased_import() {
    let out = extract_file(&fp("src/service.rs"));
    // `use std::io::Result as IoResult;` -> after Task 2 fix, emits BOTH
    // canonical "std::io::Result" AND alias "IoResult" as separate import nodes.
    let import_labels: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.kind.as_deref() == Some("import"))
        .map(|n| n.label.as_str())
        .collect();
    assert!(
        import_labels.iter().any(|l| *l == "std::io::Result"),
        "canonical aliased import label missing; got {import_labels:?}"
    );
    assert!(
        import_labels.iter().any(|l| *l == "IoResult"),
        "alias import label missing; got {import_labels:?}"
    );
}

#[test]
fn service_emits_glob_import_for_types_star() {
    let out = extract_file(&fp("src/service.rs"));
    // `use crate::types::*;`
    assert!(
        out.nodes.iter().any(|n| n.kind.as_deref() == Some("import")
            && n.label.contains("types") && n.label.contains("*")),
        "glob import not preserved; nodes = {:#?}",
        out.nodes
    );
}

#[test]
fn service_emits_implements_edge_for_greet_for_service() {
    let out = extract_file(&fp("src/service.rs"));
    let implements: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "implements")
        .collect();
    assert!(
        implements
            .iter()
            .any(|e| e.source.ends_with("::Service") && e.target.ends_with("::Greet")),
        "missing implements edge Service -> Greet; edges = {implements:#?}"
    );
}

#[test]
fn service_does_not_emit_call_to_external_println() {
    let out = extract_file(&fp("src/service.rs"));
    let all_calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    // Anchor the assertion: at least one `calls` edge must exist in service.rs
    // (Service::run calls format_name). Without this, the negative assertion below
    // would pass trivially if the call-edge subsystem were silently broken.
    assert!(
        !all_calls.is_empty(),
        "no `calls` edges from service.rs — exclusion check would be vacuous; edges = {:#?}",
        out.edges
    );
    let println_calls: Vec<_> = all_calls
        .iter()
        .filter(|e| e.target.contains("println"))
        .collect();
    assert!(
        println_calls.is_empty(),
        "unexpected call edge to println: {println_calls:#?}"
    );
}

#[test]
fn helpers_emits_top_level_functions() {
    let out = extract_file(&fp("src/helpers.rs"));
    assert_extract_has(&out, "format_name", "function");
    assert_extract_has(&out, "unrelated_helper", "function");
}

#[test]
fn types_emits_enum_trait_alias_const_static() {
    let out = extract_file(&fp("src/types.rs"));
    assert_extract_has(&out, "State", "enum");
    assert_extract_has(&out, "Greet", "trait");
    assert_extract_has(&out, "UserId", "type");
    assert_extract_has(&out, "MAX_RETRIES", "const");
    assert_extract_has(&out, "SERVICE_NAME", "static");
}

#[test]
fn empty_file_emits_zero_nodes() {
    let out = extract_file(&fp("src/empty.rs"));
    assert!(out.nodes.is_empty(), "empty.rs produced nodes: {:#?}", out.nodes);
    assert!(out.edges.is_empty(), "empty.rs produced edges: {:#?}", out.edges);
}

// ---------- Edge cases (inline, no fixture file) ----------

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("broken.rs");
    std::fs::write(&p, "fn ((( unterminated\n").unwrap();
    let _ = extract_file(&p); // must not panic; output may be empty or partial
}

#[test]
fn non_utf8_bytes_with_rs_suffix_do_not_crash() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("bad.rs");
    std::fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    // Either Ok(empty/partial) or Err - never a panic.
    let _ = graphy_core::extract::extract(&p);
}

#[test]
fn fixture_dir_points_at_expected_path() {
    let p = fixture_dir(LANG);
    let s = p.to_string_lossy();
    assert!(
        s.ends_with("fixtures/lang-coverage/rust"),
        "fixture_dir(rust) returned unexpected path: {s}"
    );
    assert!(p.join("src/lib.rs").exists(), "expected fixture file missing: {}", p.display());
}
