//! The autokey family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const AUTOKEY_ID: &str = "autokey";

/// Category label shown by the live reporter.
pub fn autokey_category() -> &'static str {
    "poly"
}
