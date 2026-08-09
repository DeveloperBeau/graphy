/// Key material for the scytale family (grid geometry).
pub const SCYTALE_KEY_KIND: &str = "grid geometry";

pub fn scytale_default_key() -> usize {
    5
}

/// One-line key description for the report footer.
pub fn scytale_key_label() -> String {
    format!("scytale <{}>", SCYTALE_KEY_KIND)
}
