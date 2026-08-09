//! The lcg_stream family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const LCG_STREAM_ID: &str = "lcg_stream";

/// Category label shown by the live reporter.
pub fn lcg_stream_category() -> &'static str {
    "stream"
}
