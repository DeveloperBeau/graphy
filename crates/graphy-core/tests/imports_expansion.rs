use graphy_core::extract::common::{expand_import_paths, is_glob};

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
    assert_eq!(got, vec!["a::b".to_string(), "a::c".to_string()]);
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
