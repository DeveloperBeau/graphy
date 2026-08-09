/// Key material for the rc4 family (keystream seed).
pub const RC4_KEY_KIND: &str = "keystream seed";

pub fn rc4_default_key() -> &'static [u8] {
    b"tundra-seed"
}

/// One-line key description for the report footer.
pub fn rc4_key_label() -> String {
    format!("rc4 <{}>", RC4_KEY_KIND)
}
