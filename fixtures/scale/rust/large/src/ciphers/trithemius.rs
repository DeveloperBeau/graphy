//! The trithemius family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const TRITHEMIUS_ID: &str = "trithemius";

/// Category label shown by the live reporter.
pub fn trithemius_category() -> &'static str {
    "classical"
}
