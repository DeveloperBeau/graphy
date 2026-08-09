//! The fnv1a family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const FNV1A_ID: &str = "fnv1a";

/// Category label shown by the live reporter.
pub fn fnv1a_category() -> &'static str {
    "hash"
}
