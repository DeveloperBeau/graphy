//! The salsa_lite family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const SALSA_LITE_ID: &str = "salsa_lite";

/// Category label shown by the live reporter.
pub fn salsa_lite_category() -> &'static str {
    "stream"
}
