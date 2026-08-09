//! The railfence family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const RAILFENCE_ID: &str = "railfence";

/// Category label shown by the live reporter.
pub fn railfence_category() -> &'static str {
    "trans"
}
