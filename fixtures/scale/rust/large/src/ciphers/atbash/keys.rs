/// Key material for the atbash family (alphabet mapping).
pub const ATBASH_KEY_KIND: &str = "alphabet mapping";

pub fn atbash_default_key() -> u8 {
    0
}

/// One-line key description for the report footer.
pub fn atbash_key_label() -> String {
    format!("atbash <{}>", ATBASH_KEY_KIND)
}
