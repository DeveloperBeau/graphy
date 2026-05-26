use graphy_core::extract::common::{expand_import_paths, is_glob};
use graphy_core::extract::extract;
use std::fs;
use tempfile::tempdir;

#[test]
fn expand_single_path() {
    assert_eq!(expand_import_paths("a::b::c"), vec!["a::b::c".to_string()]);
}

#[test]
fn expand_braced() {
    let mut got = expand_import_paths("a::{b, c}");
    got.sort();
    assert_eq!(got, vec!["a::b".to_string(), "a::c".to_string()]);
}

#[test]
fn expand_braced_nested() {
    let mut got = expand_import_paths("a::{b::{c, d}, e}");
    got.sort();
    assert_eq!(got,
        vec!["a::b::c".to_string(), "a::b::d".to_string(), "a::e".to_string()]);
}

#[test]
fn expand_braced_with_as_alias() {
    let mut got = expand_import_paths("a::{b as foo, c}");
    got.sort();
    // canonical `a::b` and alias `foo` are both emitted; `a::c` unchanged.
    assert_eq!(got, vec!["a::b".to_string(), "a::c".to_string(), "foo".to_string()]);
}

#[test]
fn expand_glob_preserved() {
    assert_eq!(expand_import_paths("a::*"), vec!["a::*".to_string()]);
    assert!(is_glob("a::*"));
}

#[test]
fn expand_glob_inside_braces() {
    let mut got = expand_import_paths("a::{*, b}");
    got.sort();
    assert_eq!(got, vec!["a::*".to_string(), "a::b".to_string()]);
}

#[test]
fn expand_falls_back_on_unparseable() {
    // Single unbalanced brace is treated as a single raw path.
    let got = expand_import_paths("a::{b, c");
    assert_eq!(got, vec!["a::{b, c".to_string()]);
}

#[test]
fn rust_brace_import_expands_to_multiple_externs() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "use crate::a::{helper, other}; fn main() {}\n").unwrap();
    let out = extract(&p).unwrap();
    let externs: Vec<_> = out
        .nodes
        .iter()
        .filter(|n| n.id.starts_with("extern::"))
        .map(|n| n.label.clone())
        .collect();
    assert!(
        externs.iter().any(|l| l.contains("helper")) &&
        externs.iter().any(|l| l.contains("other")),
        "expected both helper and other extern nodes, got {:?}", externs
    );
    assert!(externs.len() >= 2);
}

#[test]
fn python_from_import_expands_per_name() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.py");
    fs::write(&p, "from a import helper, other\n").unwrap();
    let out = extract(&p).unwrap();
    let externs: Vec<_> = out.nodes.iter()
        .filter(|n| n.id.starts_with("extern::"))
        .map(|n| n.label.clone())
        .collect();
    assert!(externs.iter().any(|l| l.contains("helper")));
    assert!(externs.iter().any(|l| l.contains("other")));
    assert!(externs.len() >= 2);
}

#[test]
fn js_named_import_expands_per_specifier() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.ts");
    fs::write(&p,
        "import { Helper, Other } from './a';\nfunction main(){}\n").unwrap();
    let out = extract(&p).unwrap();
    let externs: Vec<_> = out.nodes.iter()
        .filter(|n| n.id.starts_with("extern::"))
        .map(|n| n.label.clone()).collect();
    assert!(externs.iter().any(|l| l.contains("Helper")));
    assert!(externs.iter().any(|l| l.contains("Other")));
    assert!(externs.len() >= 2);
}

#[test]
fn python_relative_import_does_not_double_dot() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("x.py");
    fs::write(&p, "from . import helper\nfrom ..pkg import x\n").unwrap();
    let out = extract(&p).unwrap();
    let labels: Vec<String> = out.nodes.iter()
        .filter(|n| n.id.starts_with("extern::"))
        .map(|n| n.label.clone())
        .collect();
    assert!(
        labels.iter().all(|l| !l.starts_with("..h") && !l.contains("...")),
        "relative imports produced consecutive dots: {labels:?}"
    );
    assert!(
        labels.iter().any(|l| l == ".helper"),
        "expected '.helper' from `from . import helper`, got {labels:?}"
    );
    assert!(
        labels.iter().any(|l| l == "..pkg.x"),
        "expected '..pkg.x' from `from ..pkg import x`, got {labels:?}"
    );
}

#[test]
fn java_wildcard_import_marked_as_glob() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("X.java");
    fs::write(&p, "import java.util.*;\nclass X {}\n").unwrap();
    let out = extract(&p).unwrap();
    let externs: Vec<_> = out.nodes.iter()
        .filter(|n| n.id.starts_with("extern::"))
        .map(|n| n.label.clone())
        .collect();
    assert!(externs.iter().any(|l| l == "java.util.*"),
        "expected java.util.* extern, got {:?}", externs);
}
