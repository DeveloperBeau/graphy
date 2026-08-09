/// Key material for the rot13 family (alphabet mapping).
pub const ROT13_KEY_KIND: &str = "alphabet mapping";

pub fn rot13_default_key() -> u8 {
    13
}

/// One-line key description for the report footer.
pub fn rot13_key_label() -> String {
    format!("rot13 <{}>", ROT13_KEY_KIND)
}
