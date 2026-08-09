/// Key material for the fnv1a family (digest seed).
pub const FNV1A_KEY_KIND: &str = "digest seed";

pub fn fnv1a_default_key() -> u64 {
    0xcbf2_9ce4_8422_2325
}

/// One-line key description for the report footer.
pub fn fnv1a_key_label() -> String {
    format!("fnv1a <{}>", FNV1A_KEY_KIND)
}
