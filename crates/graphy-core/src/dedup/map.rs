//! Persisted dedup decisions per source file.

use std::collections::{HashMap, HashSet};

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

use crate::schema::{Confidence, ExtractionOutput};

/// Apply a [`DedupMap`] to an [`ExtractionOutput`] in place.
///
/// - Nodes whose id appears in `redirects` are dropped (their canonical
///   sibling lives at the redirect target).
/// - Edges whose source or target is redirected are retargeted; if
///   `confidence_downgrade` is set the edge confidence is lowered to
///   [`Confidence::Inferred`].
/// - Nodes whose id appears in `ambiguous_marked` have `?ambiguous`
///   appended to their `kind` field.
pub fn apply_dedup_map(out: &mut ExtractionOutput, map: &DedupMap) {
    if map.redirects.is_empty() && map.ambiguous_marked.is_empty() {
        return;
    }
    let redirects: HashMap<&str, &Redirect> = map
        .redirects
        .iter()
        .map(|r| (r.from.as_str(), r))
        .collect();
    let ambiguous: HashSet<&str> = map
        .ambiguous_marked
        .iter()
        .map(|s| s.as_str())
        .collect();

    // Drop nodes that were redirected (their canonical sibling lives elsewhere).
    out.nodes.retain(|n| !redirects.contains_key(n.id.as_str()));
    // Append `?ambiguous` on flagged nodes.
    for n in out.nodes.iter_mut() {
        if ambiguous.contains(n.id.as_str()) {
            let kind = n.kind.clone().unwrap_or_default();
            if !kind.ends_with("?ambiguous") {
                n.kind = Some(format!("{kind}?ambiguous"));
            }
        }
    }
    // Retarget edges.
    for e in out.edges.iter_mut() {
        if let Some(r) = redirects.get(e.source.as_str()) {
            e.source = r.to.clone();
            if r.confidence_downgrade {
                e.confidence = Confidence::Inferred;
            }
        }
        if let Some(r) = redirects.get(e.target.as_str()) {
            e.target = r.to.clone();
            if r.confidence_downgrade {
                e.confidence = Confidence::Inferred;
            }
        }
    }
}
