//! The djb2 family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const DJB2_ID: &str = "djb2";

/// Category label shown by the live reporter.
pub fn djb2_category() -> &'static str {
    "hash"
}
