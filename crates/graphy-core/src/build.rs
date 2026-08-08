//! Merge per-file [`ExtractionOutput`]s into one [`KnowledgeGraph`].

use petgraph::Direction;

use crate::graph::KnowledgeGraph;
use crate::schema::{Confidence, Edge, ExtractionOutput};

pub fn build_graph<I: IntoIterator<Item = ExtractionOutput>>(extractions: I) -> KnowledgeGraph {
    let mut g = KnowledgeGraph::new();
    for ex in extractions {
        for n in ex.nodes {
            g.add_node_record(n);
        }
        for e in ex.edges {
            g.add_edge_record(e);
        }
    }
    anchor_orphan_definitions(&mut g);
    g
}

/// Connectivity invariant: every definition node must hang off something.
/// Most extractors emit a `file → definition` `contains` edge themselves,
/// but some (and third-party plugins) push nodes directly. Anchor any
/// definition that has a source file but no incoming `contains` edge.
pub(crate) fn anchor_orphan_definitions(g: &mut KnowledgeGraph) {
    let mut missing: Vec<(String, String)> = Vec::new();
    for (id, &idx) in g.by_id.iter() {
        if id.starts_with("extern::") {
            continue;
        }
        let data = &g.graph[idx];
        if matches!(data.kind.as_deref(), Some("import") | Some("extern")) {
            continue;
        }
        let Some(file) = data.source_file.as_deref() else {
            continue;
        };
        if id == file {
            continue; // the file node itself
        }
        let contained = g
            .graph
            .edges_directed(idx, Direction::Incoming)
            .any(|e| petgraph::visit::EdgeRef::weight(&e).relation == "contains");
        if !contained {
            missing.push((file.to_string(), id.clone()));
        }
    }
    for (file, id) in missing {
        g.add_edge_record(Edge {
            source: file,
            target: id,
            relation: "contains".into(),
            confidence: Confidence::Extracted,
            attr: None,
        });
    }
}
