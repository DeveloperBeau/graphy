//! The affine family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const AFFINE_ID: &str = "affine";

/// Category label shown by the live reporter.
pub fn affine_category() -> &'static str {
    "classical"
}
