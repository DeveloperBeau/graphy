//! Targeted tests to close residual coverage gaps in modules whose normal
//! happy-path tests live in other files.

use std::fs;

use graphy_core::extract::extract;
use graphy_core::security::validate_graph_path;
use tempfile::tempdir;

// ---------- extract dispatch ----------

#[test]
fn extract_path_without_extension_returns_empty() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("Makefile");
    fs::write(&p, "all:\n\techo hi\n").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.is_empty());
}

#[test]
fn extract_jsx_routes_to_javascript() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("c.jsx");
    fs::write(&p, "function Btn(){return null;}\n").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "Btn"));
}

#[test]
fn extract_mjs_routes_to_javascript() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("e.mjs");
    fs::write(&p, "export function f(){}\n").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "f"));
}

#[test]
fn extract_cjs_routes_to_javascript() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("e.cjs");
    fs::write(&p, "function g(){}\nmodule.exports = g;\n").unwrap();
    let out = extract(&p).unwrap();
    assert!(out.nodes.iter().any(|n| n.label == "g"));
}

// ---------- pipeline convenience ----------

#[test]
fn pipeline_top_level_run_writes_outputs() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let out = graphy_core::pipeline::run(dir.path()).unwrap();
    assert!(out.paths.graph_json.exists());
    assert!(out.analysis.node_count >= 1);
}

// ---------- security branches ----------

#[test]
fn validate_handles_curdir_segments() {
    let dir = tempdir().unwrap();
    fs::create_dir_all(dir.path().join("sub")).unwrap();
    let with_dot = dir.path().join("sub/./graph.json");
    validate_graph_path(dir.path(), &with_dot).unwrap();
}

#[test]
fn validate_rejects_relative_path_climbing_above_cwd_root() {
    // Build a path with as many ".." as the cwd is deep, then one more.
    let depth = std::env::current_dir().unwrap().components().count();
    let mut bogus = std::path::PathBuf::new();
    for _ in 0..(depth + 5) {
        bogus.push("..");
    }
    bogus.push("escape.json");
    let err = validate_graph_path(std::path::Path::new("/"), &bogus).unwrap_err();
    assert!(err.to_string().contains("escapes root"));
}

#[test]
fn validate_filesystem_root_is_its_own_canonical_form() {
    let r = validate_graph_path(std::path::Path::new("/"), std::path::Path::new("/tmp"));
    assert!(r.is_ok());
}
