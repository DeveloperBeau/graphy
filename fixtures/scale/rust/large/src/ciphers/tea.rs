//! The tea family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const TEA_ID: &str = "tea";

/// Category label shown by the live reporter.
pub fn tea_category() -> &'static str {
    "block"
}
