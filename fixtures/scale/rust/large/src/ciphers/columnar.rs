//! The columnar family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const COLUMNAR_ID: &str = "columnar";

/// Category label shown by the live reporter.
pub fn columnar_category() -> &'static str {
    "trans"
}
