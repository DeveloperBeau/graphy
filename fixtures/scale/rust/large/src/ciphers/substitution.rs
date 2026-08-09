//! The substitution family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SUBSTITUTION_ID: &str = "substitution";

/// Category label shown by the live reporter.
pub fn substitution_category() -> &'static str {
    "classical"
}
