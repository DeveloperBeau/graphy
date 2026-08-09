//! The caesar family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const CAESAR_ID: &str = "caesar";

/// Category label shown by the live reporter.
pub fn caesar_category() -> &'static str {
    "classical"
}
