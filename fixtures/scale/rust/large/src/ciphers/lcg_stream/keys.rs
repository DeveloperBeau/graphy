/// Key material for the lcg_stream family (keystream seed).
pub const LCG_STREAM_KEY_KIND: &str = "keystream seed";

pub fn lcg_stream_default_key() -> u32 {
    0xDEAD_BEEF
}

/// One-line key description for the report footer.
pub fn lcg_stream_key_label() -> String {
    format!("lcg_stream <{}>", LCG_STREAM_KEY_KIND)
}
