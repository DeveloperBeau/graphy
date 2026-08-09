//! The adler32 family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const ADLER32_ID: &str = "adler32";

/// Category label shown by the live reporter.
pub fn adler32_category() -> &'static str {
    "hash"
}
