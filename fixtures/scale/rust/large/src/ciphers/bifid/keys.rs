/// Key material for the bifid family (grid geometry).
pub const BIFID_KEY_KIND: &str = "grid geometry";

pub fn bifid_default_key() -> u8 {
    0
}

/// One-line key description for the report footer.
pub fn bifid_key_label() -> String {
    format!("bifid <{}>", BIFID_KEY_KIND)
}
