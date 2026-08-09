//! The crc32 family: submodules plus registry metadata.

pub mod bench;
pub mod cipher;
pub mod keys;
pub mod runner;

/// Stable identifier used in reports and the results database.
pub const CRC32_ID: &str = "crc32";

/// Category label shown by the live reporter.
pub fn crc32_category() -> &'static str {
    "hash"
}
