/// Key material for the sdbm family (digest seed).
pub const SDBM_KEY_KIND: &str = "digest seed";

pub fn sdbm_default_key() -> u64 {
    0
}

/// One-line key description for the report footer.
pub fn sdbm_key_label() -> String {
    format!("sdbm <{}>", SDBM_KEY_KIND)
}
