//! `extract::go`.

use std::fs;

use graphy_core::extract::extract;
use tempfile::tempdir;

fn run(src: &str) -> graphy_core::schema::ExtractionOutput {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.go");
    fs::write(&p, src).unwrap();
    let r = extract(&p).unwrap();
    std::mem::forget(dir);
    r
}

#[test]
fn extracts_func_and_type() {
    let out = run("package x\ntype S struct{}\nfunc F(){}\n");
    let labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(labels.contains(&"F"));
    assert!(labels.contains(&"S"));
}

#[test]
fn extracts_imports() {
    let out = run("package x\nimport (\n  \"fmt\"\n  \"os\"\n)\nfunc F(){}\n");
    let imports: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "imports")
        .collect();
    assert!(imports.len() >= 2);
}

#[test]
fn extracts_method_declaration() {
    let out = run("package x\ntype S struct{}\nfunc (s *S) M() {}\n");
    assert!(out.nodes.iter().any(|n| n.label == "M"));
}

#[test]
fn empty_go_file_safe() {
    let out = run("package x\n");
    assert!(out.nodes.is_empty());
}

#[test]
fn malformed_go_does_not_panic() {
    let _ = run("package x\nfunc broken(\n");
}

#[test]
fn empty_import_path_is_dropped_safely() {
    // tree-sitter parses `import ""` — verify our emit_import path
    // short-circuits on the empty trimmed string.
    let out = run("package x\nimport \"\"\nfunc f(){}\n");
    let imports: Vec<_> = out
        .edges
        .iter()
        .filter(|e| e.relation == "imports")
        .collect();
    assert!(
        imports.is_empty(),
        "empty import path should not yield an edge"
    );
}

#[test]
fn extracts_local_calls_inside_function_body() {
    let out = run("package x\nfunc helper() {}\nfunc main() { helper(); helper() }\n");
    let calls: Vec<_> = out.edges.iter().filter(|e| e.relation == "calls").collect();
    assert!(!calls.is_empty(), "expected call edges");
}

#[test]
fn extracts_methods_invoking_each_other() {
    let out = run("package x\ntype S struct{}\nfunc (s *S) a() {}\nfunc (s *S) b() { s.a() }\n");
    assert!(out.nodes.iter().any(|n| n.label == "a"));
    assert!(out.nodes.iter().any(|n| n.label == "b"));
}

#[test]
fn hostile_giant_go_file_handled() {
    let mut body = String::from("package x\n");
    for i in 0..2500 {
        body.push_str(&format!("func F{i}() {{}}\n"));
    }
    let out = run(&body);
    assert!(out.nodes.len() >= 2500);
}
