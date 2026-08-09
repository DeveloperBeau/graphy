/// Key material for the autokey family (keyword schedule).
pub const AUTOKEY_KEY_KIND: &str = "keyword schedule";

pub fn autokey_default_key() -> &'static str {
    "FORTIFY"
}

/// One-line key description for the report footer.
pub fn autokey_key_label() -> String {
    format!("autokey <{}>", AUTOKEY_KEY_KIND)
}
