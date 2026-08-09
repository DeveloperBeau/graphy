/// Key material for the pearson family (digest seed).
pub const PEARSON_KEY_KIND: &str = "digest seed";

pub fn pearson_default_key() -> u64 {
    0x9E
}

/// One-line key description for the report footer.
pub fn pearson_key_label() -> String {
    format!("pearson <{}>", PEARSON_KEY_KIND)
}
