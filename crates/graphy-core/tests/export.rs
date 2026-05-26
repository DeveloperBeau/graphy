//! `export` module: writes the `graphy-out/` tri-output bundle.

use std::fs;

use graphy_core::analyze::analyze;
use graphy_core::build::build_graph;
use graphy_core::export::{OUT_DIR_NAME, export};
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use tempfile::tempdir;

fn n(id: &str) -> Node {
    Node {
        id: id.into(),
        label: id.into(),
        source_file: None,
        source_location: None,
        kind: None,
    }
}

#[test]
fn export_writes_three_files_with_expected_names() {
    let dir = tempdir().unwrap();
    let ex = ExtractionOutput {
        nodes: vec![n("a")],
        edges: vec![],
    };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    let paths = export(dir.path(), &g, &a).unwrap();
    assert!(paths.graph_json.exists());
    assert!(paths.report_md.exists());
    assert!(paths.graph_html.exists());
    let out = dir.path().join(OUT_DIR_NAME);
    assert!(out.is_dir());
}

#[test]
fn graph_json_is_pretty_and_parses() {
    let dir = tempdir().unwrap();
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b")],
        edges: vec![Edge {
            source: "a".into(),
            target: "b".into(),
            relation: "calls".into(),
            confidence: Confidence::Extracted,
        }],
    };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    let paths = export(dir.path(), &g, &a).unwrap();
    let body = fs::read_to_string(&paths.graph_json).unwrap();
    assert!(
        body.contains('\n'),
        "pretty-printed JSON should contain newlines"
    );
    let _: serde_json::Value = serde_json::from_str(&body).unwrap();
}

#[test]
fn graph_html_contains_embedded_data() {
    let dir = tempdir().unwrap();
    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let paths = export(dir.path(), &g, &a).unwrap();
    let html = fs::read_to_string(&paths.graph_html).unwrap();
    assert!(html.contains("<!doctype html>"));
    assert!(html.contains("graphy"));
}

#[test]
fn graph_html_is_self_contained_interactive_viewer() {
    let dir = tempdir().unwrap();
    let ex = ExtractionOutput {
        nodes: vec![n("hub"), n("a"), n("b")],
        edges: vec![
            Edge {
                source: "hub".into(),
                target: "a".into(),
                relation: "calls".into(),
                confidence: Confidence::Inferred,
            },
            Edge {
                source: "hub".into(),
                target: "b".into(),
                relation: "imports".into(),
                confidence: Confidence::Extracted,
            },
        ],
    };
    let g = build_graph(vec![ex]);
    let a = analyze(&g);
    let paths = export(dir.path(), &g, &a).unwrap();
    let html = fs::read_to_string(&paths.graph_html).unwrap();

    // No external resources — the viewer must run offline.
    assert!(
        !html.contains("http://"),
        "should not link to external resources"
    );
    assert!(
        !html.contains("https://"),
        "should not link to external resources"
    );

    // Inline data + interactive scaffolding.
    assert!(html.contains("const DATA ="));
    assert!(html.contains("\"hub\""));
    assert!(html.contains("<svg id=\"svg\""));
    assert!(html.contains("highlight"));
    assert!(html.contains("addEventListener"));
    // Legend covers each relation type our render styles.
    assert!(html.contains("calls"));
    assert!(html.contains("imports"));
}

#[test]
fn export_overwrites_existing_outputs() {
    let dir = tempdir().unwrap();
    let g1 = build_graph(vec![ExtractionOutput {
        nodes: vec![n("a")],
        edges: vec![],
    }]);
    let a1 = analyze(&g1);
    let _ = export(dir.path(), &g1, &a1).unwrap();

    let g2 = build_graph(vec![ExtractionOutput {
        nodes: vec![n("a"), n("b")],
        edges: vec![],
    }]);
    let a2 = analyze(&g2);
    let paths = export(dir.path(), &g2, &a2).unwrap();

    let body = fs::read_to_string(&paths.graph_json).unwrap();
    let v: serde_json::Value = serde_json::from_str(&body).unwrap();
    assert_eq!(v["nodes"].as_array().unwrap().len(), 2);
}

#[test]
fn export_surfaces_io_error_when_graph_json_path_is_a_directory() {
    // Pre-create graphy-out/graph.json as a *directory* so `fs::write` cannot
    // overwrite it, forcing the `?` on the graph.json write to fire.
    let dir = tempdir().unwrap();
    let out = dir.path().join("graphy-out");
    fs::create_dir_all(out.join("graph.json")).unwrap();

    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let err = export(dir.path(), &g, &a).unwrap_err();
    let msg = err.to_string().to_lowercase();
    assert!(
        msg.contains("is a directory") || msg.contains("directory") || msg.contains("permission"),
        "unexpected error: {msg}"
    );
}

#[test]
#[cfg(unix)]
fn export_surfaces_io_error_when_output_dir_is_readonly() {
    use std::os::unix::fs::PermissionsExt;
    let dir = tempdir().unwrap();
    let root = dir.path().join("locked");
    fs::create_dir_all(&root).unwrap();
    let mut perms = fs::metadata(&root).unwrap().permissions();
    perms.set_mode(0o500); // r-x, no write
    fs::set_permissions(&root, perms).unwrap();

    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let err = export(&root, &g, &a).unwrap_err();
    let msg = err.to_string();
    assert!(
        msg.contains("mkdir")
            || msg.to_lowercase().contains("permission")
            || msg.to_lowercase().contains("denied"),
        "unexpected error: {msg}"
    );

    // restore so tempdir can clean up
    let mut perms = fs::metadata(&root).unwrap().permissions();
    perms.set_mode(0o700);
    let _ = fs::set_permissions(&root, perms);
}

#[test]
fn export_creates_output_root_if_missing() {
    let dir = tempdir().unwrap();
    let nested = dir.path().join("nested/output");
    let g = build_graph(Vec::<ExtractionOutput>::new());
    let a = analyze(&g);
    let paths = export(&nested, &g, &a).unwrap();
    assert!(paths.graph_json.exists());
}
