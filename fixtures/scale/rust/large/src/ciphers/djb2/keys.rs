/// Key material for the djb2 family (digest seed).
pub const DJB2_KEY_KIND: &str = "digest seed";

pub fn djb2_default_key() -> u64 {
    5381
}

/// One-line key description for the report footer.
pub fn djb2_key_label() -> String {
    format!("djb2 <{}>", DJB2_KEY_KIND)
}
