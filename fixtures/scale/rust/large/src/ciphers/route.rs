//! The route family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const ROUTE_ID: &str = "route";

/// Category label shown by the live reporter.
pub fn route_category() -> &'static str {
    "trans"
}
