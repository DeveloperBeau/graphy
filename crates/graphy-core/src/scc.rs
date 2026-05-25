//! Strongly-connected component index used to widen delta-Louvain's hot
//! frontier so community labels propagate fully through cycles.

use std::collections::HashMap;
use std::fs;
use std::path::Path;

use petgraph::algo::tarjan_scc;
use serde::{Deserialize, Serialize};

use crate::graph::KnowledgeGraph;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct SccIndex {
    /// Per-component, the node ids that belong to it. Components of size 1
    /// are omitted to keep the index small.
    pub components: Vec<Vec<String>>,
    /// id → component index. Nodes not in this map are size-1 components.
    #[serde(default)]
    pub by_id: HashMap<String, usize>,
    /// Schema version for forward compatibility.
    pub version: u32,
}

impl SccIndex {
    pub const CURRENT_VERSION: u32 = 1;

    pub fn build(g: &KnowledgeGraph) -> Self {
        // Build reverse map idx → id once.
        let mut idx_to_id: HashMap<petgraph::graph::NodeIndex, String> =
            HashMap::with_capacity(g.by_id.len());
        for (id, &idx) in &g.by_id {
            idx_to_id.insert(idx, id.clone());
        }

        let sccs = tarjan_scc(&g.graph);
        let mut components: Vec<Vec<String>> = Vec::new();
        let mut by_id: HashMap<String, usize> = HashMap::new();
        for component in sccs {
            if component.len() < 2 {
                continue;
            }
            let mut ids: Vec<String> = component
                .into_iter()
                .filter_map(|idx| idx_to_id.get(&idx).cloned())
                .collect();
            ids.sort();
            let i = components.len();
            for id in &ids {
                by_id.insert(id.clone(), i);
            }
            components.push(ids);
        }
        Self {
            components,
            by_id,
            version: Self::CURRENT_VERSION,
        }
    }

    pub fn component_of<'a>(&'a self, id: &'a str) -> Vec<&'a str> {
        if let Some(&i) = self.by_id.get(id) {
            self.components[i].iter().map(String::as_str).collect()
        } else {
            vec![id]
        }
    }

    pub fn save(&self, out_root: &Path) -> std::io::Result<()> {
        let dir = out_root.join("graphy-out").join(".cache");
        fs::create_dir_all(&dir)?;
        let path = dir.join("scc.json");
        let json = serde_json::to_vec_pretty(self).map_err(std::io::Error::other)?;
        fs::write(path, json)
    }

    pub fn load(out_root: &Path) -> Option<Self> {
        let path = out_root.join("graphy-out").join(".cache").join("scc.json");
        let bytes = fs::read(&path).ok()?;
        let s: Self = serde_json::from_slice(&bytes).ok()?;
        if s.version != Self::CURRENT_VERSION {
            return None;
        }
        Some(s)
    }
}

impl Default for SccIndex {
    fn default() -> Self {
        Self {
            components: Vec::new(),
            by_id: HashMap::new(),
            version: Self::CURRENT_VERSION,
        }
    }
}
