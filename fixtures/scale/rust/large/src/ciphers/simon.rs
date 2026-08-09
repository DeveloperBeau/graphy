//! The simon family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SIMON_ID: &str = "simon";

/// Category label shown by the live reporter.
pub fn simon_category() -> &'static str {
    "block"
}
