/// Key material for the substitution family (alphabet mapping).
pub const SUBSTITUTION_KEY_KIND: &str = "alphabet mapping";

pub fn substitution_default_key() -> &'static [u8; 26] {
    b"QWERTYUIOPASDFGHJKLZXCVBNM"
}

/// One-line key description for the report footer.
pub fn substitution_key_label() -> String {
    format!("substitution <{}>", SUBSTITUTION_KEY_KIND)
}
