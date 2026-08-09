/// Key material for the railfence family (grid geometry).
pub const RAILFENCE_KEY_KIND: &str = "grid geometry";

pub fn railfence_default_key() -> usize {
    3
}

/// One-line key description for the report footer.
pub fn railfence_key_label() -> String {
    format!("railfence <{}>", RAILFENCE_KEY_KIND)
}
