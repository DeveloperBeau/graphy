//! The beaufort family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const BEAUFORT_ID: &str = "beaufort";

/// Category label shown by the live reporter.
pub fn beaufort_category() -> &'static str {
    "poly"
}
