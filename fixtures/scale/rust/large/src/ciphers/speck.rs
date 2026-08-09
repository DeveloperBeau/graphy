//! The speck family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SPECK_ID: &str = "speck";

/// Category label shown by the live reporter.
pub fn speck_category() -> &'static str {
    "block"
}
