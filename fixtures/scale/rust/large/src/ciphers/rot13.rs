//! The rot13 family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const ROT13_ID: &str = "rot13";

/// Category label shown by the live reporter.
pub fn rot13_category() -> &'static str {
    "classical"
}
