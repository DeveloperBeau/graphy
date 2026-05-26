#[path = "lang_coverage/common.rs"]
mod common;

#[test]
fn fixture_dir_points_at_repo_lang_coverage_path() {
    let p = common::fixture_dir("rust");
    let s = p.to_string_lossy();
    assert!(s.ends_with("fixtures/lang-coverage/rust"), "got {s}");
}

#[test]
fn assert_extract_has_succeeds_for_present_node() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("x.rs");
    std::fs::write(&p, "fn helper() {}\n").unwrap();
    let out = common::extract_file(&p);
    common::assert_extract_has(&out, "helper", "function");
}

#[test]
#[should_panic(expected = "assert_extract_has failed")]
fn assert_extract_has_panics_with_lang_context_on_miss() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("x.rs");
    std::fs::write(&p, "fn helper() {}\n").unwrap();
    let out = common::extract_file(&p);
    common::assert_extract_has(&out, "nope", "function");
}
