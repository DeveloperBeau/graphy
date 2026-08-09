//! The atbash family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const ATBASH_ID: &str = "atbash";

/// Category label shown by the live reporter.
pub fn atbash_category() -> &'static str {
    "classical"
}
