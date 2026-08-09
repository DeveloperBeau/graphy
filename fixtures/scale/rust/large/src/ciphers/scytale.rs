//! The scytale family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SCYTALE_ID: &str = "scytale";

/// Category label shown by the live reporter.
pub fn scytale_category() -> &'static str {
    "trans"
}
