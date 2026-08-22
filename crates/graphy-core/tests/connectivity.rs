//! Graph connectivity invariant: extraction + dedup must never leave a
//! node with no edges. Every definition hangs off its file via `contains`,
//! imports and qualified calls attach through extern nodes, and dedup
//! redirects those externs onto real definitions where one exists.

use graphy_core::pipeline::{Pipeline, PipelineConfig};
use petgraph::Direction;
use std::path::{Path, PathBuf};

fn fixture(name: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join(name)
}

fn lang_coverage_fixture(lang: &str) -> PathBuf {
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage")
        .join(lang)
}

#[test]
fn python_fixture_has_no_isolated_nodes() {
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(fixture("python-mini-cli"));
    cfg.out_root = out.path().to_path_buf();
    let result = Pipeline::new(cfg).run().unwrap();

    let g = &result.graph.graph;
    let isolated: Vec<String> = g
        .node_indices()
        .filter(|&ni| {
            g.neighbors_directed(ni, Direction::Incoming).count() == 0
                && g.neighbors_directed(ni, Direction::Outgoing).count() == 0
        })
        .map(|ni| g[ni].label.clone())
        .collect();
    assert!(
        isolated.is_empty(),
        "isolated nodes in python fixture: {isolated:?}"
    );
}

#[test]
fn python_cross_file_calls_resolve_to_definitions() {
    let out = tempfile::tempdir().unwrap();
    let mut cfg = PipelineConfig::new(fixture("python-mini-cli"));
    cfg.out_root = out.path().to_path_buf();
    let result = Pipeline::new(cfg).run().unwrap();

    let json = result.graph.to_json_value();
    let edges = json["edges"].as_array().unwrap();
    let has_edge = |src_end: &str, rel: &str, tgt_end: &str| {
        edges.iter().any(|e| {
            e["source"].as_str().unwrap().ends_with(src_end)
                && e["relation"] == rel
                && e["target"].as_str().unwrap().ends_with(tgt_end)
        })
    };

    // main() calls a function defined in a sibling module.
    assert!(
        has_edge("__main__.py::main", "calls", "util.py::banner"),
        "main -> banner call did not resolve"
    );
    // Imported bare name resolves through the extern to the definition.
    assert!(
        has_edge("hello.py::run", "calls", "util.py::say"),
        "run -> say call did not resolve"
    );
    // Dotted import resolved onto the definition, not a phantom extern.
    assert!(
        has_edge("hello.py", "imports", "util.py::say"),
        "hello.py import did not dedup onto util.py::say"
    );
    // Definitions anchor to their file.
    assert!(
        has_edge("util.py", "contains", "util.py::say"),
        "missing contains edge for util.py::say"
    );
}

// ---------- Table-driven cross-file call resolution across lang-coverage ----------

/// (fixture dir under fixtures/lang-coverage, caller id suffix, callee id suffix)
///
/// Every language whose fixture declares `cross-file call` in a source comment
/// is in this table or in KNOWN_GAPS. `declared_intent_is_covered` enforces
/// that, so a new language fixture cannot quietly declare the intent and
/// deliver nothing.
const CROSS_FILE_CALLS: &[(&str, &str, &str)] = &[
    ("c", "service.c::service_run", "helpers.c::format_name"),
    ("cpp", "service.cpp::run", "helpers.cpp::format_name"),
    ("csharp", "Service.cs::Run", "Helpers.cs::FormatName"),
    ("go", "service.go::Run", "helpers.go::FormatName"),
    ("java", "Service.java::run", "Helpers.java::formatName"),
    ("kotlin", "Service.kt::run", "Helpers.kt::formatName"),
    ("python", "service.py::run", "helpers.py::format_name"),
    ("ruby", "service.rb::run", "helpers.rb::format_name"),
    ("rust", "service.rs::run", "helpers.rs::format_name"),
    ("swift", "Service.swift::run", "Helpers.swift::formatName"),
    ("zig", "service.zig::run", "helpers.zig::format_name"),
];

/// Languages whose fixture declares `cross-file call` and that this change does
/// NOT fix, with the reason. A tester reading a failure here is reading a
/// *fixed* gap, not a regression.
const KNOWN_GAPS: &[(&str, &str, &str, &str)] = &[
    (
        "javascript",
        "service.js::run",
        "helpers.js::formatName",
        "the import registers the leaf, so emit_call resolves locally to \
         extern::./helpers.js/formatName and never records an unresolved call; \
         dedup::best_match splits extern labels on `::` and `.` but not `/`, so \
         that extern never reaches the definition. Fix dedup, then move this row up.",
    ),
    (
        "typescript",
        "service.ts::run",
        "helpers.ts::formatName",
        "same as javascript",
    ),
];

#[test]
fn cross_file_calls_resolve_per_language() {
    for &(lang, caller, callee) in CROSS_FILE_CALLS {
        let out = tempfile::tempdir().unwrap();
        let mut cfg = PipelineConfig::new(lang_coverage_fixture(lang));
        cfg.out_root = out.path().to_path_buf();
        let result = Pipeline::new(cfg)
            .run()
            .unwrap_or_else(|e| panic!("pipeline failed for {lang}: {e:#}"));

        let json = result.graph.to_json_value();
        let edges = json["edges"].as_array().unwrap();
        let has_edge = edges.iter().any(|e| {
            e["relation"] == "calls"
                && e["source"].as_str().unwrap().ends_with(caller)
                && e["target"].as_str().unwrap().ends_with(callee)
        });
        if !has_edge {
            let calls_edges: Vec<_> = edges.iter().filter(|e| e["relation"] == "calls").collect();
            panic!(
                "{lang}: no calls edge from *{caller} to *{callee}; calls edges = {calls_edges:#?}"
            );
        }
    }
}

#[test]
fn known_gap_languages_still_do_not_resolve() {
    for &(lang, caller, callee, reason) in KNOWN_GAPS {
        let out = tempfile::tempdir().unwrap();
        let mut cfg = PipelineConfig::new(lang_coverage_fixture(lang));
        cfg.out_root = out.path().to_path_buf();
        let result = Pipeline::new(cfg)
            .run()
            .unwrap_or_else(|e| panic!("pipeline failed for {lang}: {e:#}"));

        let json = result.graph.to_json_value();
        let edges = json["edges"].as_array().unwrap();
        let has_edge = edges.iter().any(|e| {
            e["relation"] == "calls"
                && e["source"].as_str().unwrap().ends_with(caller)
                && e["target"].as_str().unwrap().ends_with(callee)
        });
        assert!(
            !has_edge,
            "{lang} now resolves its cross-file call — promote it from \
             KNOWN_GAPS to CROSS_FILE_CALLS: {reason}"
        );
    }
}

#[test]
fn declared_intent_is_covered() {
    use std::collections::BTreeSet;

    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let lang_coverage_dir = manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage");

    let mut declared: BTreeSet<String> = BTreeSet::new();
    let mut stack = vec![lang_coverage_dir.clone()];
    while let Some(dir) = stack.pop() {
        let Ok(entries) = std::fs::read_dir(&dir) else {
            continue;
        };
        for entry in entries.flatten() {
            let path = entry.path();
            if path.is_dir() {
                stack.push(path);
                continue;
            }
            if path.file_name().and_then(|n| n.to_str()) == Some("README.md") {
                continue;
            }
            let Ok(text) = std::fs::read_to_string(&path) else {
                continue;
            };
            if text.contains("cross-file call") {
                let rel = path.strip_prefix(&lang_coverage_dir).unwrap();
                if let Some(lang) = rel.components().next() {
                    declared.insert(lang.as_os_str().to_string_lossy().into_owned());
                }
            }
        }
    }

    let mut covered: BTreeSet<String> = BTreeSet::new();
    covered.extend(
        CROSS_FILE_CALLS
            .iter()
            .map(|&(lang, _, _)| lang.to_string()),
    );
    covered.extend(KNOWN_GAPS.iter().map(|&(lang, _, _, _)| lang.to_string()));

    assert_eq!(
        declared, covered,
        "languages declaring `cross-file call` in fixtures/lang-coverage must \
         appear in exactly one of CROSS_FILE_CALLS or KNOWN_GAPS"
    );
}

#[test]
fn no_unresolved_edges_in_any_fixture() {
    let out = tempfile::tempdir().unwrap();
    let manifest = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let lang_coverage_dir = manifest
        .parent()
        .and_then(Path::parent)
        .expect("repo root above crates/graphy-core")
        .join("fixtures")
        .join("lang-coverage");
    let mut cfg = PipelineConfig::new(lang_coverage_dir);
    cfg.out_root = out.path().to_path_buf();
    cfg.include_docs = true;
    let result = Pipeline::new(cfg).run().unwrap();

    let json = result.graph.to_json_value();
    let edges = json["edges"].as_array().unwrap();
    for e in edges {
        assert_ne!(
            e["relation"].as_str().unwrap(),
            "calls?unresolved",
            "unresolved sentinel edge reached the graph: {e}"
        );
    }
    let nodes = json["nodes"].as_array().unwrap();
    for n in nodes {
        let id = n["id"].as_str().unwrap();
        assert!(
            !id.starts_with("unresolved::"),
            "unresolved sentinel node reached the graph: {id}"
        );
    }
}
