#[path = "lang_coverage/common.rs"]
mod common;

#[test]
fn fixture_dir_points_at_repo_lang_coverage_path() {
    let p = common::fixture_dir("rust");
    let s = p.to_string_lossy();
    assert!(s.ends_with("fixtures/lang-coverage/rust"), "got {s}");
}
