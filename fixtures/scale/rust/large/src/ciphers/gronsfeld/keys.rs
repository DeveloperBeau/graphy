/// Key material for the gronsfeld family (keyword schedule).
pub const GRONSFELD_KEY_KIND: &str = "keyword schedule";

pub fn gronsfeld_default_key() -> &'static [u8] {
    &[3, 1, 4, 1, 5, 9]
}

/// One-line key description for the report footer.
pub fn gronsfeld_key_label() -> String {
    format!("gronsfeld <{}>", GRONSFELD_KEY_KIND)
}
