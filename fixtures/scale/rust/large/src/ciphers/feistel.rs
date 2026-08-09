//! The feistel family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const FEISTEL_ID: &str = "feistel";

/// Category label shown by the live reporter.
pub fn feistel_category() -> &'static str {
    "block"
}
