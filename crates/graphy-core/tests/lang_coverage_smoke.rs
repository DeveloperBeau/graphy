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

#[test]
fn assert_extract_edge_finds_calls_edge() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("x.rs");
    std::fs::write(&p, "fn helper() {}\nfn main() { helper(); }\n").unwrap();
    let out = common::extract_file(&p);
    common::assert_extract_edge(&out, "main", "helper", "calls");
}

#[test]
#[should_panic(expected = "assert_extract_edge failed")]
fn assert_extract_edge_panics_with_edge_dump_on_miss() {
    let dir = tempfile::tempdir().unwrap();
    let p = dir.path().join("x.rs");
    std::fs::write(&p, "fn helper() {}\nfn main() { helper(); }\n").unwrap();
    let out = common::extract_file(&p);
    common::assert_extract_edge(&out, "main", "missing", "calls");
}

#[test]
fn run_pipeline_produces_a_graph_for_a_one_file_project() {
    let dir = tempfile::tempdir().unwrap();
    std::fs::create_dir_all(dir.path().join("src")).unwrap();
    std::fs::write(
        dir.path().join("src/lib.rs"),
        "pub fn helper() {}\npub fn main_fn() { helper(); }\n",
    )
    .unwrap();
    let (g, _guard) = common::run_pipeline(dir.path());
    assert!(g.node_count() >= 2, "expected nodes in graph, got {}", g.node_count());
}

#[test]
fn graph_assertions_work_against_pipeline_output() {
    let dir = tempfile::tempdir().unwrap();
    std::fs::create_dir_all(dir.path().join("src")).unwrap();
    std::fs::write(
        dir.path().join("src/lib.rs"),
        "pub fn helper() {}\npub fn main_fn() { helper(); }\n",
    )
    .unwrap();
    let (g, _guard) = common::run_pipeline(dir.path());
    common::assert_node(&g, "helper", "function");
    common::assert_edge(&g, "main_fn", "helper", "calls");
    common::assert_no_edge(&g, "helper", "main_fn");
}

#[test]
#[should_panic(expected = "assert_node failed")]
fn assert_node_panics_with_graph_dump_on_miss() {
    let dir = tempfile::tempdir().unwrap();
    std::fs::create_dir_all(dir.path().join("src")).unwrap();
    std::fs::write(dir.path().join("src/lib.rs"), "pub fn helper() {}\n").unwrap();
    let (g, _guard) = common::run_pipeline(dir.path());
    common::assert_node(&g, "ghost", "function");
}

#[test]
#[should_panic(expected = "assert_no_edge failed: missing node label")]
fn assert_no_edge_panics_when_a_label_is_missing() {
    let dir = tempfile::tempdir().unwrap();
    std::fs::create_dir_all(dir.path().join("src")).unwrap();
    std::fs::write(
        dir.path().join("src/lib.rs"),
        "pub fn helper() {}\npub fn main_fn() { helper(); }\n",
    )
    .unwrap();
    let (g, _guard) = common::run_pipeline(dir.path());
    common::assert_no_edge(&g, "main_fn", "nonexistent");
}
