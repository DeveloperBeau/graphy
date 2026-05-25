//! Persisted hierarchical Louvain state.
//!
//! Every Louvain pass produces a (community vector, folded adjacency)
//! pair. [`LouvainLevels`] is the on-disk representation of the whole
//! pyramid, used to seed incremental runs.

use std::collections::HashMap;
use std::path::Path;

use serde::{Deserialize, Serialize};

pub const SCHEMA_VERSION: u32 = 1;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LouvainLevels {
    pub version: u32,
    pub graph_hash: String,
    pub modularity: f64,
    pub levels: Vec<LevelState>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct LevelState {
    /// Base-level only: canonical node id -> super-node index.
    /// Empty at levels >= 1; use `community` to navigate up.
    #[serde(default)]
    pub node_to_super: HashMap<String, usize>,
    pub super_adjacency: Vec<Vec<(usize, f64)>>,
    pub community: Vec<usize>,
}

impl LouvainLevels {
    pub fn load(path: &Path) -> Option<Self> {
        let text = std::fs::read_to_string(path).ok()?;
        let parsed: LouvainLevels = serde_json::from_str(&text).ok()?;
        if parsed.version != SCHEMA_VERSION {
            return None;
        }
        Some(parsed)
    }

    pub fn save(&self, path: &Path) -> anyhow::Result<()> {
        if let Some(parent) = path.parent() {
            std::fs::create_dir_all(parent)?;
        }
        let tmp = path.with_extension("json.tmp");
        std::fs::write(&tmp, serde_json::to_vec_pretty(self)?)?;
        std::fs::rename(&tmp, path)?;
        Ok(())
    }
}

use crate::graph::KnowledgeGraph;

pub fn graph_hash_of(g: &KnowledgeGraph) -> String {
    use blake3::Hasher;
    use petgraph::visit::{EdgeRef, IntoEdgeReferences};

    // Build idx -> id reverse map once.
    let mut idx_to_id: HashMap<petgraph::graph::NodeIndex, String> =
        HashMap::with_capacity(g.by_id.len());
    for (id, &idx) in &g.by_id {
        idx_to_id.insert(idx, id.clone());
    }

    let mut node_ids: Vec<&str> = g.by_id.keys().map(|s| s.as_str()).collect();
    node_ids.sort_unstable();

    let mut hasher = Hasher::new();
    for id in &node_ids {
        hasher.update(b"N:");
        hasher.update(id.as_bytes());
        hasher.update(b"\n");
    }
    let mut edges: Vec<(String, String, String)> = g
        .graph
        .edge_references()
        .filter_map(|e| {
            let s = idx_to_id.get(&e.source())?.clone();
            let t = idx_to_id.get(&e.target())?.clone();
            Some((s, t, e.weight().relation.clone()))
        })
        .collect();
    edges.sort();
    for (s, t, r) in &edges {
        hasher.update(b"E:");
        hasher.update(s.as_bytes());
        hasher.update(b" ");
        hasher.update(t.as_bytes());
        hasher.update(b" ");
        hasher.update(r.as_bytes());
        hasher.update(b"\n");
    }
    format!("blake3:{}", hasher.finalize().to_hex())
}
