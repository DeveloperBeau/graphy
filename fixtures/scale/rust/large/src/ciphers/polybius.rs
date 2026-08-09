//! The polybius family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const POLYBIUS_ID: &str = "polybius";

/// Category label shown by the live reporter.
pub fn polybius_category() -> &'static str {
    "trans"
}
