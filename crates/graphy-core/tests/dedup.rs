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
    assert!(g.by_id.get("extern::crate::a::helper").is_none());
    let helper = g
        .by_id
        .get("a.rs::helper")
        .expect("helper survived dedup");
    let data = &g.graph[*helper];
    assert!(
        data.aliases.contains(&"extern::crate::a::helper".to_string()),
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
    let remaining: Vec<_> = g.graph.node_weights().filter(|n| n.label == "helper").collect();
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
    assert!(g.graph[*target]
        .aliases
        .contains(&"extern::a::helper".to_string()));
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
