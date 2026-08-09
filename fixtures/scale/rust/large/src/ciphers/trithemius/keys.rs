/// Key material for the trithemius family (alphabet mapping).
pub const TRITHEMIUS_KEY_KIND: &str = "alphabet mapping";

pub fn trithemius_default_key() -> u8 {
    0
}

/// One-line key description for the report footer.
pub fn trithemius_key_label() -> String {
    format!("trithemius <{}>", TRITHEMIUS_KEY_KIND)
}
