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

    /// Incrementally update the index after edges touching `dirty_ids` have
    /// been added or removed from `g`.
    ///
    /// The algorithm:
    /// 1. Seed the frontier with the dirty nodes plus every current component
    ///    that already contains a dirty node (handles splits).
    /// 2. Expand 2 hops in both directions so cross-component bridges are
    ///    reachable.
    /// 3. Run Tarjan SCC on the induced subgraph.
    /// 4. Drop all old components that overlap the frontier and replace them
    ///    with the freshly-computed ones (size ≥ 2 only).
    /// 5. Rebuild `by_id`.
    pub fn patch(&mut self, g: &KnowledgeGraph, dirty_ids: &[String]) {
        use petgraph::Direction;
        use petgraph::visit::{EdgeRef, NodeFiltered};
        use std::collections::HashSet;

        if dirty_ids.is_empty() {
            return;
        }

        // Build idx ↔ id maps for the current graph.
        let mut idx_to_id: HashMap<petgraph::graph::NodeIndex, String> =
            HashMap::with_capacity(g.by_id.len());
        for (id, &idx) in &g.by_id {
            idx_to_id.insert(idx, id.clone());
        }

        // 1. Collect dirty NodeIndexes.
        let mut frontier: HashSet<petgraph::graph::NodeIndex> = HashSet::new();
        for id in dirty_ids {
            if let Some(&idx) = g.by_id.get(id) {
                frontier.insert(idx);
            }
        }

        // 2. Expand: include every node in any currently-known component that
        //    touches a dirty id (so component splits are visible).
        let mut additions: Vec<petgraph::graph::NodeIndex> = Vec::new();
        for id in dirty_ids {
            if let Some(&comp_idx) = self.by_id.get(id) {
                for member in &self.components[comp_idx] {
                    if let Some(&i) = g.by_id.get(member) {
                        additions.push(i);
                    }
                }
            }
        }
        frontier.extend(additions);

        // 3. 2-hop neighbour expansion so cross-component bridges produced by
        //    edge additions are reachable from the frontier.
        let mut hops: Vec<petgraph::graph::NodeIndex> = Vec::new();
        for &n in &frontier {
            for e in g.graph.edges_directed(n, Direction::Outgoing) {
                hops.push(e.target());
            }
            for e in g.graph.edges_directed(n, Direction::Incoming) {
                hops.push(e.source());
            }
        }
        frontier.extend(hops);
        // Second hop.
        let snapshot: Vec<_> = frontier.iter().copied().collect();
        let mut hops2: Vec<petgraph::graph::NodeIndex> = Vec::new();
        for n in snapshot {
            for e in g.graph.edges_directed(n, Direction::Outgoing) {
                hops2.push(e.target());
            }
            for e in g.graph.edges_directed(n, Direction::Incoming) {
                hops2.push(e.source());
            }
        }
        frontier.extend(hops2);

        // 4. Run tarjan_scc on the induced subgraph.
        let sub = NodeFiltered::from_fn(&g.graph, |n| frontier.contains(&n));
        let new_components = tarjan_scc(&sub);

        // 5. Drop any old components that overlap the frontier; replace with
        //    the newly-discovered ones (size >= 2).
        let mut keep: Vec<Vec<String>> = Vec::new();
        'outer: for comp in self.components.drain(..) {
            for member in &comp {
                if let Some(&i) = g.by_id.get(member)
                    && frontier.contains(&i)
                {
                    continue 'outer;
                }
            }
            keep.push(comp);
        }
        self.components = keep;

        for comp in new_components {
            if comp.len() < 2 {
                continue;
            }
            let mut ids: Vec<String> = comp
                .into_iter()
                .filter_map(|idx| idx_to_id.get(&idx).cloned())
                .collect();
            ids.sort();
            self.components.push(ids);
        }

        // 6. Rebuild by_id.
        self.by_id.clear();
        for (i, comp) in self.components.iter().enumerate() {
            for id in comp {
                self.by_id.insert(id.clone(), i);
            }
        }
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
