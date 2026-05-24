//! `extract::python`.

use std::fs;

use graphy_core::extract::extract;
use tempfile::tempdir;

#[test]
fn extracts_def_and_class() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.py");
    fs::write(&p, "def f(): pass\nclass C:\n    def g(self): pass\n").unwrap();
    let out = extract(&p).unwrap();
    let labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(labels.contains(&"f"));
    assert!(labels.contains(&"C"));
    assert!(labels.contains(&"g"));
}

#[test]
fn extracts_imports() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.py");
    fs::write(&p, "import os\nfrom typing import List\n").unwrap();
    let out = extract(&p).unwrap();
    let imports: Vec<_> = out.edges.iter().filter(|e| e.relation == "imports").collect();
    assert!(imports.len() >= 2);
}

#[test]
fn extracts_local_calls() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.py");
    fs::write(&p, "def helper(): pass\ndef main(): helper(); helper()\n").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn empty_python_file_safe() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("e.py");
    fs::write(&p, "").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.is_empty());
}

#[test]
fn malformed_python_does_not_panic() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("bad.py");
    fs::write(&p, "def : :::\n  if if if\n").unwrap();
    let _ = extract(&p).unwrap();
}

#[test]
fn hostile_giant_file_handled() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("big.py");
    let mut body = String::new();
    for i in 0..3000 { body.push_str(&format!("def f{i}(): pass\n")); }
    fs::write(&p, body).unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.len() >= 3000);
}
