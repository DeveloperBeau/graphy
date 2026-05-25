//! Persisted dedup decisions per source file.

use serde::{Deserialize, Serialize};

pub const SCHEMA_VERSION: u32 = 1;

#[derive(Debug, Clone, Serialize, Deserialize, Default)]
pub struct DedupMap {
    pub version: u32,
    pub for_extraction: String,
    #[serde(default)]
    pub redirects: Vec<Redirect>,
    #[serde(default)]
    pub ambiguous_marked: Vec<String>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Redirect {
    pub from: String,
    pub to: String,
    #[serde(default)]
    pub edge_relation: Option<String>,
    #[serde(default)]
    pub confidence_downgrade: bool,
}

impl DedupMap {
    pub fn empty_for(hash: impl Into<String>) -> Self {
        Self {
            version: SCHEMA_VERSION,
            for_extraction: hash.into(),
            redirects: Vec::new(),
            ambiguous_marked: Vec::new(),
        }
    }
}
