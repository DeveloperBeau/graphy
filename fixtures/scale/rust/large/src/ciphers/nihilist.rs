//! The nihilist family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const NIHILIST_ID: &str = "nihilist";

/// Category label shown by the live reporter.
pub fn nihilist_category() -> &'static str {
    "poly"
}
