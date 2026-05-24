//! Schema-validate extractor output before graph build.

use anyhow::{Result, anyhow};

use crate::schema::ExtractionOutput;

pub fn validate(ex: &ExtractionOutput) -> Result<()> {
    for n in &ex.nodes {
        if n.id.is_empty() {
            return Err(anyhow!("node id is empty"));
        }
        if n.label.is_empty() {
            return Err(anyhow!("node {} has empty label", n.id));
        }
    }
    for e in &ex.edges {
        if e.source.is_empty() || e.target.is_empty() {
            return Err(anyhow!("edge missing source/target"));
        }
        if e.relation.is_empty() {
            return Err(anyhow!("edge {}->{} missing relation", e.source, e.target));
        }
    }
    Ok(())
}
