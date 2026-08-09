/// Key material for the adler32 family (digest seed).
pub const ADLER32_KEY_KIND: &str = "digest seed";

pub fn adler32_default_key() -> u64 {
    1
}

/// One-line key description for the report footer.
pub fn adler32_key_label() -> String {
    format!("adler32 <{}>", ADLER32_KEY_KIND)
}
