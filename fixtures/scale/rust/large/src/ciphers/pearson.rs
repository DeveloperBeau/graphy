//! The pearson family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const PEARSON_ID: &str = "pearson";

/// Category label shown by the live reporter.
pub fn pearson_category() -> &'static str {
    "hash"
}
