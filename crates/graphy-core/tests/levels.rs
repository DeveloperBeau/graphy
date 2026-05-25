//! Persisted hierarchical Louvain levels.

use graphy_core::cluster::levels::{LevelState, LouvainLevels, graph_hash_of};
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use tempfile::tempdir;
use std::fs;

#[test]
fn roundtrip_serialises_and_deserialises_levels() {
    let levels = LouvainLevels {
        version: 1,
        graph_hash: "blake3:test".into(),
        modularity: 0.42,
        levels: vec![LevelState {
            node_to_super: [("a".into(), 0_usize), ("b".into(), 1)]
                .into_iter().collect(),
            super_adjacency: vec![vec![(1, 1.0)], vec![(0, 1.0)]],
            community: vec![0, 0],
        }],
    };
    let json = serde_json::to_string(&levels).unwrap();
    let parsed: LouvainLevels = serde_json::from_str(&json).unwrap();
    assert_eq!(parsed.version, 1);
    assert_eq!(parsed.levels.len(), 1);
    assert_eq!(parsed.levels[0].community, vec![0, 0]);
}

#[test]
fn cache_load_returns_none_on_missing_file() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("nope.json");
    assert!(LouvainLevels::load(&p).is_none());
}

#[test]
fn cache_load_returns_none_on_corrupt_json() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("bad.json");
    fs::write(&p, "{ not valid json").unwrap();
    assert!(LouvainLevels::load(&p).is_none());
}

#[test]
fn cache_load_returns_none_on_version_mismatch() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("v0.json");
    fs::write(&p, r#"{"version":0,"graph_hash":"x","modularity":0.0,"levels":[]}"#).unwrap();
    assert!(LouvainLevels::load(&p).is_none());
}

#[test]
fn save_then_load_roundtrip() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("levels.json");
    let levels = LouvainLevels {
        version: 1, graph_hash: "g".into(), modularity: 0.1,
        levels: vec![LevelState {
            node_to_super: Default::default(),
            super_adjacency: vec![vec![]],
            community: vec![0],
        }],
    };
    levels.save(&p).unwrap();
    let back = LouvainLevels::load(&p).unwrap();
    assert_eq!(back.levels.len(), 1);
}

#[test]
fn recorder_captures_one_level_per_outer_pass() {
    let nodes = (0..6)
        .map(|i| Node {
            id: i.to_string(),
            label: i.to_string(),
            source_file: None,
            source_location: None,
            kind: None,
        })
        .collect();
    let edges = vec![(0, 1), (1, 2), (0, 2), (3, 4), (4, 5), (3, 5), (2, 3)]
        .into_iter()
        .map(|(s, t)| Edge {
            source: s.to_string(),
            target: t.to_string(),
            relation: "calls".into(),
            confidence: Confidence::Extracted,
        })
        .collect();
    let mut g = graphy_core::build::build_graph(vec![ExtractionOutput { nodes, edges }]);
    let mut rec = graphy_core::cluster::levels::LevelRecorder::new();
    graphy_core::cluster::cluster_with_recorder(&mut g, &mut rec);
    let levels = rec.into_levels();
    assert!(!levels.is_empty(), "expected at least one recorded level");
    // Level 0 should carry the base node_to_super map.
    assert!(
        !levels[0].node_to_super.is_empty(),
        "level 0 missing base node_to_super"
    );
}

#[test]
fn graph_hash_changes_when_any_edge_changes() {
    let g_a = graphy_core::build::build_graph(vec![ExtractionOutput {
        nodes: vec![
            Node { id: "a".into(), label: "a".into(), source_file: None, source_location: None, kind: None },
            Node { id: "b".into(), label: "b".into(), source_file: None, source_location: None, kind: None },
        ],
        edges: vec![Edge {
            source: "a".into(), target: "b".into(),
            relation: "calls".into(), confidence: Confidence::Extracted,
        }],
    }]);
    let g_b = graphy_core::build::build_graph(vec![ExtractionOutput {
        nodes: vec![
            Node { id: "a".into(), label: "a".into(), source_file: None, source_location: None, kind: None },
            Node { id: "b".into(), label: "b".into(), source_file: None, source_location: None, kind: None },
        ],
        edges: vec![],
    }]);
    assert_ne!(graph_hash_of(&g_a), graph_hash_of(&g_b));
}

#[test]
fn propagate_dirty_handles_empty_dirty_set() {
    let levels = LouvainLevels { version: 1, graph_hash: "x".into(),
        modularity: 0.0, levels: vec![] };
    let out = levels.propagate_dirty(&[]);
    assert!(out.is_empty());
}

#[test]
fn propagate_dirty_climbs_levels_when_moves_happen() {
    // 4 base nodes, 2 super-nodes at level 0, 1 super-node at level 1.
    let levels = LouvainLevels {
        version: 1, graph_hash: "x".into(), modularity: 0.1,
        levels: vec![
            LevelState {
                node_to_super: [("a".into(), 0_usize), ("b".into(), 0),
                                ("c".into(), 1), ("d".into(), 1)]
                    .into_iter().collect(),
                super_adjacency: vec![vec![(1, 1.0)], vec![(0, 1.0)]],
                community: vec![0, 0],
            },
            LevelState {
                node_to_super: Default::default(),
                super_adjacency: vec![vec![]],
                community: vec![0],
            },
        ],
    };
    let out = levels.propagate_dirty(&["a".to_string()]);
    assert_eq!(out.len(), 2);
    assert!(out[0].contains(&0));        // super 0 at level 0
    assert!(out[1].contains(&0));        // super 0 at level 1
}

#[test]
fn hierarchical_seeded_preserves_unchanged_communities() {
    // Build two disconnected K3s; first run gives 2 communities. Touch
    // one node in K3-A; hierarchical-seeded should keep K3-B intact.
    let nodes = (0..6)
        .map(|i| Node { id: i.to_string(), label: i.to_string(),
            source_file: None, source_location: None, kind: None })
        .collect();
    let edges = [(0,1),(1,2),(0,2),(3,4),(4,5),(3,5)]
        .iter().map(|(s,t)| Edge {
            source: s.to_string(), target: t.to_string(),
            relation: "calls".into(), confidence: Confidence::Extracted,
        }).collect();
    let mut g = graphy_core::build::build_graph(vec![ExtractionOutput { nodes, edges }]);
    let mut rec = graphy_core::cluster::levels::LevelRecorder::new();
    graphy_core::cluster::cluster_with_recorder(&mut g, &mut rec);
    let prior = graphy_core::cluster::levels::LouvainLevels {
        version: 1,
        graph_hash: graphy_core::cluster::levels::graph_hash_of(&g),
        modularity: 0.0,
        levels: rec.into_levels(),
    };
    let comm_b_before: u32 = g.graph[g.by_id["3"]].community.unwrap();

    let dirty_idx = g.by_id["0"];
    graphy_core::cluster::cluster_hierarchical_seeded(&mut g, &[dirty_idx], &prior);

    let comm_b_after: u32 = g.graph[g.by_id["3"]].community.unwrap();
    assert_eq!(comm_b_before, comm_b_after,
        "untouched K3-B community label drifted");
}
