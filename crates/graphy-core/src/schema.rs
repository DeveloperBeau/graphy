//! Extractor output schema: nodes + edges with explicit confidence labels.

use serde::{Deserialize, Serialize};

/// Confidence label on an [`Edge`].
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Serialize, Deserialize)]
#[serde(rename_all = "UPPERCASE")]
pub enum Confidence {
    /// Relationship explicitly stated in source (import, direct call).
    Extracted,
    /// Reasonable deduction (call-graph second pass, co-occurrence).
    Inferred,
    /// Uncertain; flagged for human review in GRAPH_REPORT.md.
    Ambiguous,
}

impl Confidence {
    pub fn as_str(self) -> &'static str {
        match self {
            Self::Extracted => "EXTRACTED",
            Self::Inferred => "INFERRED",
            Self::Ambiguous => "AMBIGUOUS",
        }
    }
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Node {
    pub id: String,
    pub label: String,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_file: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_location: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub kind: Option<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Edge {
    pub source: String,
    pub target: String,
    pub relation: String,
    pub confidence: Confidence,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct ExtractionOutput {
    #[serde(default)]
    pub nodes: Vec<Node>,
    #[serde(default)]
    pub edges: Vec<Edge>,
}

impl ExtractionOutput {
    pub fn merge(&mut self, other: ExtractionOutput) {
        self.nodes.extend(other.nodes);
        self.edges.extend(other.edges);
    }
}
