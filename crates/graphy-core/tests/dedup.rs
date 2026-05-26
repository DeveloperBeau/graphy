//! `dedup` module: cross-file import resolution + alias collapse + ambiguity flag.

use graphy_core::build::build_graph;
use graphy_core::dedup::dedup;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};

fn n(id: &str, kind: &str, source_file: &str) -> Node {
    let label = id.rsplit("::").next().unwrap_or(id).to_string();
    Node {
        id: id.into(),
        label,
        source_file: Some(source_file.into()),
        source_location: Some("L1".into()),
        kind: Some(kind.into()),
    }
}

fn ext(id: &str, source_file: &str) -> Node {
    let label = id.trim_start_matches("extern::").to_string();
    Node {
        id: id.into(),
        label,
        source_file: Some(source_file.into()),
        source_location: Some("L1".into()),
        kind: Some("import".into()),
    }
}

fn e(s: &str, t: &str, rel: &str, c: Confidence) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: rel.into(),
        confidence: c,
    }
}

#[test]
fn extern_with_unique_local_match_collapses_into_def() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            ext("extern::crate::a::helper", "b.rs"),
        ],
        edges: vec![e(
            "b.rs",
            "extern::crate::a::helper",
            "imports",
            Confidence::Extracted,
        )],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 1);
    assert!(!g.by_id.contains_key("extern::crate::a::helper"));
    let helper = g.by_id.get("a.rs::helper").expect("helper survived dedup");
    let data = &g.graph[*helper];
    assert!(
        data.aliases
            .contains(&"extern::crate::a::helper".to_string()),
        "alias not recorded: {:?}",
        data.aliases
    );
}

#[test]
fn extern_with_no_local_match_left_untouched() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            ext("extern::serde::Serialize", "a.rs"),
        ],
        edges: vec![e(
            "a.rs",
            "extern::serde::Serialize",
            "imports",
            Confidence::Extracted,
        )],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 0);
    assert!(g.by_id.contains_key("extern::serde::Serialize"));
}

#[test]
fn extern_with_ambiguous_local_match_left_untouched() {
    // Two locals share the leaf name `helper`; the extern reference is
    // ambiguous so dedup refuses to redirect.
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            n("b.rs::helper", "function", "b.rs"),
            ext("extern::lib::helper", "c.rs"),
        ],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 0);
    assert!(g.by_id.contains_key("extern::lib::helper"));
}

#[test]
fn same_label_same_kind_no_connecting_import_marks_ambiguous() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            n("b.rs::helper", "function", "b.rs"),
        ],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.ambiguous_groups, 1);
    assert_eq!(report.reexports_merged, 0);
    for ni in g.graph.node_indices() {
        let d = &g.graph[ni];
        if d.label == "helper" {
            assert!(
                d.kind.as_deref().unwrap_or("").ends_with("?ambiguous"),
                "expected ambiguous flag on {:?}",
                d.kind
            );
        }
    }
}

#[test]
fn same_label_same_kind_with_connecting_import_merges() {
    // a.rs::helper is re-exported via b.rs::helper, with an explicit
    // imports edge between them. dedup should merge them.
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            n("b.rs::helper", "function", "b.rs"),
        ],
        edges: vec![e(
            "b.rs::helper",
            "a.rs::helper",
            "imports",
            Confidence::Extracted,
        )],
    };
    let mut g = build_graph(vec![ex]);
    let _report = dedup(&mut g);
    let remaining: Vec<_> = g
        .graph
        .node_weights()
        .filter(|n| n.label == "helper")
        .collect();
    assert_eq!(remaining.len(), 1, "the two helpers should have collapsed");
    let survivor = remaining[0];
    assert!(!survivor.aliases.is_empty(), "alias should be recorded");
}

#[test]
fn dedup_empty_graph_is_safe() {
    let mut g = graphy_core::KnowledgeGraph::new();
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 0);
    assert_eq!(report.reexports_merged, 0);
    assert_eq!(report.ambiguous_groups, 0);
}

#[test]
fn qualified_path_disambiguates_same_leaf_collision() {
    // Two helpers share a leaf name but live in different files. An
    // extern that qualifies the path with the file stem should resolve
    // to the unique correct one rather than giving up.
    let ex = ExtractionOutput {
        nodes: vec![
            n("src/a.rs::helper", "function", "src/a.rs"),
            n("src/b.rs::helper", "function", "src/b.rs"),
            ext("extern::a::helper", "src/caller.rs"),
        ],
        edges: vec![e(
            "src/caller.rs",
            "extern::a::helper",
            "imports",
            Confidence::Extracted,
        )],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(
        report.imports_resolved, 1,
        "extern::a::helper should resolve to src/a.rs::helper"
    );
    let target = g
        .by_id
        .get("src/a.rs::helper")
        .expect("a.rs helper survived");
    assert!(
        g.graph[*target]
            .aliases
            .contains(&"extern::a::helper".to_string())
    );
}

#[test]
fn qualified_path_strips_use_keyword_and_as_alias() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("src/x.rs::Helper", "function", "src/x.rs"),
            ext("extern::use x::Helper as MyHelper;", "src/caller.rs"),
        ],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(
        report.imports_resolved, 1,
        "the `use ... as ...` form should be normalised before lookup"
    );
}

#[test]
fn dedup_emits_per_file_maps() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            ext("extern::lib::helper", "b.rs"),
        ],
        edges: vec![e(
            "b.rs",
            "extern::lib::helper",
            "imports",
            Confidence::Extracted,
        )],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 1);
    let map = report.per_file_maps.get("b.rs").expect("b.rs map present");
    assert_eq!(map.redirects.len(), 1);
    assert_eq!(map.redirects[0].from, "extern::lib::helper");
    assert_eq!(map.redirects[0].to, "a.rs::helper");
}

#[test]
fn split_legacy_compound_externs_walks_braced_label() {
    use graphy_core::schema::*;
    let ex = ExtractionOutput {
        nodes: vec![
            // Legacy compound extern from before this feature shipped.
            Node {
                id: "extern::crate::a::{helper, other}".into(),
                label: "crate::a::{helper, other}".into(),
                source_file: Some("src/x.rs".into()),
                source_location: Some("L1".into()),
                kind: Some("import".into()),
            },
            Node {
                id: "src/a.rs::helper".into(),
                label: "helper".into(),
                source_file: Some("src/a.rs".into()),
                source_location: Some("L2".into()),
                kind: Some("function".into()),
            },
        ],
        edges: vec![Edge {
            source: "src/x.rs".into(),
            target: "extern::crate::a::{helper, other}".into(),
            relation: "imports".into(),
            confidence: Confidence::Extracted,
        }],
    };
    let mut g = graphy_core::build::build_graph(vec![ex]);
    let _report = graphy_core::dedup::dedup(&mut g);
    // After the legacy split, the compound extern is gone, and the
    // expanded `extern::crate::a::helper` resolves to src/a.rs::helper.
    assert!(!g.by_id.contains_key("extern::crate::a::{helper, other}"));
    let helper = g
        .by_id
        .get("src/a.rs::helper")
        .expect("helper canonical survived");
    assert!(
        g.graph[*helper]
            .aliases
            .iter()
            .any(|s| s.contains("helper"))
    );
    // The unmatched `other` should still be on the graph as its own
    // extern node.
    assert!(g.by_id.keys().any(|k| k.contains("crate::a::other")));
}

#[test]
fn split_legacy_compound_preserves_alias_on_existing_node() {
    use graphy_core::schema::*;
    let ex = ExtractionOutput {
        nodes: vec![
            // Already-split fresh extern that shares a leaf with the compound.
            Node {
                id: "extern::crate::a::helper".into(),
                label: "crate::a::helper".into(),
                source_file: Some("src/x.rs".into()),
                source_location: Some("L1".into()),
                kind: Some("import".into()),
            },
            // Legacy compound that needs splitting.
            Node {
                id: "extern::crate::a::{helper, other}".into(),
                label: "crate::a::{helper, other}".into(),
                source_file: Some("src/x.rs".into()),
                source_location: Some("L1".into()),
                kind: Some("import".into()),
            },
        ],
        edges: vec![],
    };
    let mut g = graphy_core::build::build_graph(vec![ex]);
    let report = graphy_core::dedup::dedup(&mut g);
    // Two simple externs created from the compound.
    assert_eq!(
        report.compound_externs_split, 2,
        "expected 2 nodes from splitting the compound"
    );
    // The existing fresh extern should now carry the compound id as an alias.
    let idx = g
        .by_id
        .get("extern::crate::a::helper")
        .expect("fresh extern survives dedup");
    assert!(
        g.graph[*idx]
            .aliases
            .iter()
            .any(|a| a.contains("{helper, other}")),
        "compound alias not preserved on existing node: {:?}",
        g.graph[*idx].aliases
    );
}

#[test]
fn glob_extern_is_skipped_and_counted() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            ext("extern::a::*", "b.rs"),
        ],
        edges: vec![e("b.rs", "extern::a::*", "imports", Confidence::Extracted)],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(report.imports_resolved, 0, "glob must not resolve");
    assert_eq!(report.glob_imports_skipped, 1, "glob must be counted");
}

#[test]
fn glob_extern_remains_on_graph() {
    let ex = ExtractionOutput {
        nodes: vec![
            n("a.rs::helper", "function", "a.rs"),
            ext("extern::a::*", "b.rs"),
        ],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    let _report = dedup(&mut g);
    assert!(
        g.by_id.contains_key("extern::a::*"),
        "glob extern node should survive dedup"
    );
}

#[test]
fn dot_glob_python_extern_counted() {
    let ex = ExtractionOutput {
        nodes: vec![ext("extern::a.*", "b.py")],
        edges: vec![],
    };
    let mut g = build_graph(vec![ex]);
    let report = dedup(&mut g);
    assert_eq!(
        report.glob_imports_skipped, 1,
        "Python `from a import *` form must count"
    );
}

#[test]
fn dedup_resolves_each_expanded_member_independently() {
    use graphy_core::pipeline::{Pipeline, PipelineConfig};
    use std::fs;
    use tempfile::tempdir;
    let dir = tempdir().unwrap();
    fs::write(
        dir.path().join("a.rs"),
        "pub fn helper(){}\npub fn other(){}\n",
    )
    .unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "use crate::a::{helper, other};\nfn main(){ helper(); other(); }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let r = Pipeline::new(cfg).run().unwrap();
    let labels: Vec<String> = r
        .graph
        .graph
        .node_weights()
        .map(|n| n.label.clone())
        .collect();
    assert!(labels.contains(&"helper".to_string()));
    assert!(labels.contains(&"other".to_string()));
    // No compound extern survives dedup.
    assert!(
        !labels.iter().any(|l| l.contains("{")),
        "compound extern survived dedup: {:?}",
        labels
            .iter()
            .filter(|l| l.contains("{"))
            .collect::<Vec<_>>()
    );
}

#[test]
fn analysis_surfaces_glob_imports_skipped_and_modularity() {
    use graphy_core::pipeline::{Pipeline, PipelineConfig};
    use std::fs;
    use tempfile::tempdir;
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn helper() {}\n").unwrap();
    fs::write(
        dir.path().join("b.rs"),
        "use a::*;\nfn main() { helper(); }\n",
    )
    .unwrap();
    let cfg = PipelineConfig::new(dir.path());
    let r = Pipeline::new(cfg).run().unwrap();
    assert!(
        r.analysis.glob_imports_skipped >= 1,
        "expected >=1 glob skipped, got {}",
        r.analysis.glob_imports_skipped
    );
    // modularity is a heuristic; a 2-node graph commonly produces 0.0, so
    // we only check the field exists and is finite.
    assert!(
        r.analysis.modularity.is_finite(),
        "modularity must be finite, got {}",
        r.analysis.modularity
    );

    // Verify the fields also appear in stats.json on disk (not just in
    // the in-memory Analysis struct).
    let stats_text = fs::read_to_string(&r.paths.stats_json).expect("read stats.json");
    let stats: serde_json::Value =
        serde_json::from_str(&stats_text).expect("stats.json parses as JSON");
    assert!(
        stats.get("glob_imports_skipped").is_some(),
        "stats.json should contain glob_imports_skipped: {stats}"
    );
    assert!(
        stats.get("modularity").is_some(),
        "stats.json should contain modularity: {stats}"
    );
}
