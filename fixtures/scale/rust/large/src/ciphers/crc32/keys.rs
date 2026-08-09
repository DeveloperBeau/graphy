/// Key material for the crc32 family (digest seed).
pub const CRC32_KEY_KIND: &str = "digest seed";

pub fn crc32_default_key() -> u64 {
    0xFFFF_FFFF
}

/// One-line key description for the report footer.
pub fn crc32_key_label() -> String {
    format!("crc32 <{}>", CRC32_KEY_KIND)
}
