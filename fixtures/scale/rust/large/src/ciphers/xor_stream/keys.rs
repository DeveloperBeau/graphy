/// Key material for the xor_stream family (keystream seed).
pub const XOR_STREAM_KEY_KIND: &str = "keystream seed";

pub fn xor_stream_default_key() -> &'static [u8] {
    b"orchard-key"
}

/// One-line key description for the report footer.
pub fn xor_stream_key_label() -> String {
    format!("xor_stream <{}>", XOR_STREAM_KEY_KIND)
}
