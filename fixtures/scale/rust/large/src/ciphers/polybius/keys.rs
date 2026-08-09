/// Key material for the polybius family (grid geometry).
pub const POLYBIUS_KEY_KIND: &str = "grid geometry";

pub fn polybius_default_key() -> u8 {
    0
}

/// One-line key description for the report footer.
pub fn polybius_key_label() -> String {
    format!("polybius <{}>", POLYBIUS_KEY_KIND)
}
