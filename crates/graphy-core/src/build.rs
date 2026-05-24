//! Merge per-file [`ExtractionOutput`]s into one [`KnowledgeGraph`].

use crate::graph::KnowledgeGraph;
use crate::schema::ExtractionOutput;

pub fn build_graph<I: IntoIterator<Item = ExtractionOutput>>(
    extractions: I,
) -> KnowledgeGraph {
    let mut g = KnowledgeGraph::new();
    for ex in extractions {
        for n in ex.nodes {
            g.add_node_record(n);
        }
        for e in ex.edges {
            g.add_edge_record(e);
        }
    }
    g
}
