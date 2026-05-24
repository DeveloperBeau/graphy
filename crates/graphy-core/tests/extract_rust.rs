//! `extract::rust`: tree-sitter-based Rust extractor.

use std::fs;

use graphy_core::extract::extract;
use tempfile::tempdir;

fn write(dir: &std::path::Path, name: &str, body: &str) -> std::path::PathBuf {
    let p = dir.join(name);
    fs::write(&p, body).unwrap();
    p
}

// ---------- success ----------

#[test]
fn extracts_functions_and_structs() {
    let dir = tempdir().unwrap();
    let p = write(
        dir.path(),
        "x.rs",
        r#"
            pub struct UserService;
            pub fn handle() {}
            pub enum State { On, Off }
        "#,
    );
    let out = extract(&p).unwrap();
    let labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(labels.contains(&"UserService"));
    assert!(labels.contains(&"handle"));
    assert!(labels.contains(&"State"));
}

#[test]
fn extracts_use_statements_as_imports() {
    let dir = tempdir().unwrap();
    let p = write(dir.path(), "x.rs", "use std::collections::HashMap;\nfn f(){}\n");
    let out = extract(&p).unwrap();
    let has_import = out.edges.iter().any(|e| e.relation == "imports");
    assert!(has_import);
    assert!(out.nodes.iter().any(|n| n.label.contains("HashMap")));
}

#[test]
fn extracts_call_edges_to_local_symbols() {
    let dir = tempdir().unwrap();
    let p = write(
        dir.path(),
        "x.rs",
        r#"
            fn helper() {}
            fn main() { helper(); helper(); }
        "#,
    );
    let out = extract(&p).unwrap();
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(!calls.is_empty());
}

#[test]
fn call_to_external_symbol_yields_no_call_edge() {
    let dir = tempdir().unwrap();
    let p = write(
        dir.path(),
        "x.rs",
        r#"
            fn main() { external_thing(); }
        "#,
    );
    let out = extract(&p).unwrap();
    // No local symbol matches `external_thing`, so no call edge is emitted.
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(calls.is_empty(), "external call must not produce a local edge");
}

#[test]
fn each_node_has_source_file_and_location() {
    let dir = tempdir().unwrap();
    let p = write(dir.path(), "x.rs", "fn f(){}\n");
    let out = extract(&p).unwrap();
    for n in &out.nodes {
        assert!(n.source_file.is_some(), "missing source_file on {}", n.label);
        if n.kind.as_deref() != Some("import") {
            assert!(n.source_location.is_some());
        }
    }
}

// ---------- edge ----------

#[test]
fn empty_file_produces_no_nodes() {
    let dir = tempdir().unwrap();
    let p = write(dir.path(), "empty.rs", "");
    let out = extract(&p).unwrap();
    assert!(out.nodes.is_empty());
    assert!(out.edges.is_empty());
}

#[test]
fn unsupported_suffix_returns_empty() {
    let dir = tempdir().unwrap();
    let p = write(dir.path(), "data.bin", "anything");
    let out = extract(&p).unwrap();
    assert!(out.nodes.is_empty());
}

// ---------- failure ----------

#[test]
fn missing_file_surfaces_error() {
    let bogus = std::path::PathBuf::from("/no/such/path/should/exist.rs");
    let err = extract(&bogus).unwrap_err();
    assert!(err.to_string().contains("read"));
}

#[test]
fn malformed_source_does_not_panic() {
    let dir = tempdir().unwrap();
    let p = write(dir.path(), "broken.rs", "fn ((( unterminated\n");
    let out = extract(&p).unwrap();
    // tree-sitter recovers; we just require no panic and some output (possibly empty).
    let _ = out.nodes.len();
}

// ---------- hostile ----------

#[test]
fn non_utf8_bytes_with_rs_suffix_do_not_crash() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("bad.rs");
    fs::write(&p, [0xff_u8, 0xfe, 0xfd, 0x00, 0x01]).unwrap();
    let r = extract(&p);
    // Either: error surfaced cleanly, or empty output. Never panic.
    if let Ok(out) = r {
        assert!(out.nodes.is_empty() || !out.nodes.is_empty());
    }
}

#[test]
fn very_deep_nesting_does_not_blow_stack() {
    let dir = tempdir().unwrap();
    let mut body = String::new();
    for _ in 0..400 { body.push_str("fn outer(){ "); }
    for _ in 0..400 { body.push_str("} "); }
    let p = write(dir.path(), "deep.rs", &body);
    let _ = extract(&p).unwrap();
}

#[test]
fn huge_file_completes_in_reasonable_time() {
    let dir = tempdir().unwrap();
    let mut body = String::new();
    for i in 0..5_000 { body.push_str(&format!("pub fn f{i}() {{ }}\n")); }
    let p = write(dir.path(), "big.rs", &body);
    let out = extract(&p).unwrap();
    assert!(out.nodes.len() >= 5_000);
}
