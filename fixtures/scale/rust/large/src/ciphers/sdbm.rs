//! The sdbm family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SDBM_ID: &str = "sdbm";

/// Category label shown by the live reporter.
pub fn sdbm_category() -> &'static str {
    "hash"
}
