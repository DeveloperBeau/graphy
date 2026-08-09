//! The vigenere family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const VIGENERE_ID: &str = "vigenere";

/// Category label shown by the live reporter.
pub fn vigenere_category() -> &'static str {
    "poly"
}
