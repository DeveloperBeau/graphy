/// Key material for the caesar family (alphabet mapping).
pub const CAESAR_KEY_KIND: &str = "alphabet mapping";

pub fn caesar_default_key() -> u8 {
    7
}

/// One-line key description for the report footer.
pub fn caesar_key_label() -> String {
    format!("caesar <{}>", CAESAR_KEY_KIND)
}
