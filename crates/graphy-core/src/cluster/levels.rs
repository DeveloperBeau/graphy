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
    /// Return, for each level, the set of super-node indices that may
    /// require re-evaluation given the seed base-level dirty ids.
    pub fn propagate_dirty(&self, dirty_ids: &[String]) -> Vec<std::collections::HashSet<usize>> {
        if self.levels.is_empty() {
            return Vec::new();
        }
        let mut out: Vec<std::collections::HashSet<usize>> = Vec::with_capacity(self.levels.len());
        // Level 0: map ids -> super-node indices.
        let base = &self.levels[0];
        let mut current: std::collections::HashSet<usize> = dirty_ids
            .iter()
            .filter_map(|id| base.node_to_super.get(id).copied())
            .collect();
        for level in &self.levels {
            // Each "current" super-node maps up via `level.community`.
            let mut next: std::collections::HashSet<usize> = std::collections::HashSet::new();
            for &i in &current {
                if let Some(c) = level.community.get(i) {
                    next.insert(*c);
                }
                for &(j, _) in level.super_adjacency.get(i).into_iter().flatten() {
                    if let Some(c) = level.community.get(j) {
                        next.insert(*c);
                    }
                }
            }
            out.push(current);
            current = next;
        }
        out
    }

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

/// In-memory recorder that captures one [`LevelState`] per outer Louvain pass.
///
/// Call [`record_base_map`](LevelRecorder::record_base_map) once before the
/// loop to supply the original node-id → super-index mapping, then call
/// [`record_level`](LevelRecorder::record_level) after each pass. Retrieve
/// everything with [`into_levels`](LevelRecorder::into_levels).
#[derive(Default)]
pub struct LevelRecorder {
    pub(crate) records: Vec<LevelState>,
    pub(crate) base_map: Option<HashMap<String, usize>>,
}

impl LevelRecorder {
    pub fn new() -> Self {
        Self::default()
    }

    pub fn record_base_map(&mut self, map: HashMap<String, usize>) {
        self.base_map = Some(map);
    }

    pub fn record_level(&mut self, adj: &[Vec<(usize, f64)>], community: &[usize]) {
        let mut state = LevelState {
            node_to_super: HashMap::new(),
            super_adjacency: adj.to_vec(),
            community: community.to_vec(),
        };
        if self.records.is_empty()
            && let Some(map) = self.base_map.take()
        {
            state.node_to_super = map;
        }
        self.records.push(state);
    }

    pub fn into_levels(self) -> Vec<LevelState> {
        self.records
    }
}

use crate::graph::KnowledgeGraph;

/// Newman modularity Q for the current community assignment.
/// Thin alias to `crate::cluster::modularity` — one canonical implementation.
pub use crate::cluster::modularity as compute_modularity;

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
