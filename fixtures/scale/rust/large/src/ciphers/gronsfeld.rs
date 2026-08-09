//! The gronsfeld family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const GRONSFELD_ID: &str = "gronsfeld";

/// Category label shown by the live reporter.
pub fn gronsfeld_category() -> &'static str {
    "poly"
}
