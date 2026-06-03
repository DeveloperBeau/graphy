//! Extractor output schema: nodes + edges with explicit confidence labels.

use serde::{Deserialize, Serialize};

/// Confidence label on an [`Edge`].
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash, Default, Serialize, Deserialize)]
#[serde(rename_all = "UPPERCASE")]
pub enum Confidence {
    /// Relationship explicitly stated in source (import, direct call).
    Extracted,
    /// Reasonable deduction (call-graph second pass, co-occurrence).
    #[default]
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

/// Structured signature attached to a function / class / struct node.
#[derive(Debug, Clone, Default, PartialEq, Serialize, Deserialize)]
pub struct Signature {
    #[serde(default, skip_serializing_if = "Vec::is_empty")]
    pub params: Vec<ParamSig>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub returns: Option<String>,
    #[serde(default, skip_serializing_if = "Vec::is_empty")]
    pub fields: Vec<FieldSig>,
}

/// A single parameter captured from a function or method signature.
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct ParamSig {
    pub name: String,
    /// Textual type as written in source, `None` when the grammar carries none.
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub ty: Option<String>,
}

/// A single field captured from a struct or class definition.
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize)]
pub struct FieldSig {
    pub name: String,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub ty: Option<String>,
}

/// Metadata on a typed edge (`has_param` carries name + index, `has_field` name).
#[derive(Debug, Clone, Default, PartialEq, Serialize, Deserialize)]
pub struct EdgeAttr {
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub index: Option<u32>,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct Node {
    pub id: String,
    pub label: String,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_file: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub source_location: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub kind: Option<String>,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub signature: Option<Signature>,
}

#[derive(Debug, Clone, Default, Serialize, Deserialize)]
pub struct Edge {
    pub source: String,
    pub target: String,
    pub relation: String,
    pub confidence: Confidence,
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub attr: Option<EdgeAttr>,
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

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn node_signature_roundtrips_and_old_json_loads() {
        let n = Node {
            id: "f.rs::build".into(),
            label: "build".into(),
            source_file: Some("f.rs".into()),
            source_location: Some("L1".into()),
            kind: Some("function".into()),
            signature: Some(Signature {
                params: vec![ParamSig {
                    name: "w".into(),
                    ty: Some("Widget".into()),
                }],
                returns: Some("Widget".into()),
                fields: vec![],
            }),
        };
        let json = serde_json::to_string(&n).unwrap();
        let back: Node = serde_json::from_str(&json).unwrap();
        assert_eq!(back.signature, n.signature);

        // Old graph.json without `signature` still deserializes.
        let old = r#"{"id":"a","label":"a"}"#;
        let parsed: Node = serde_json::from_str(old).unwrap();
        assert!(parsed.signature.is_none());
    }

    #[test]
    fn edge_attr_roundtrips() {
        let e = Edge {
            source: "f.rs::build".into(),
            target: "extern::Widget".into(),
            relation: "has_param".into(),
            confidence: Confidence::Extracted,
            attr: Some(EdgeAttr {
                name: Some("w".into()),
                index: Some(0),
            }),
        };
        let json = serde_json::to_string(&e).unwrap();
        let back: Edge = serde_json::from_str(&json).unwrap();
        assert_eq!(back.attr, e.attr);
    }
}
