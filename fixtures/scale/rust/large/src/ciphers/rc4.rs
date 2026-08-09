//! The rc4 family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const RC4_ID: &str = "rc4";

/// Category label shown by the live reporter.
pub fn rc4_category() -> &'static str {
    "stream"
}
