//! The xor_stream family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const XOR_STREAM_ID: &str = "xor_stream";

/// Category label shown by the live reporter.
pub fn xor_stream_category() -> &'static str {
    "stream"
}
