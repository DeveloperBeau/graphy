/// Key material for the vigenere family (keyword schedule).
pub const VIGENERE_KEY_KIND: &str = "keyword schedule";

pub fn vigenere_default_key() -> &'static str {
    "LEMON"
}

/// One-line key description for the report footer.
pub fn vigenere_key_label() -> String {
    format!("vigenere <{}>", VIGENERE_KEY_KIND)
}
