/// Key material for the columnar family (grid geometry).
pub const COLUMNAR_KEY_KIND: &str = "grid geometry";

pub fn columnar_default_key() -> &'static [usize] {
    &[2, 0, 3, 1]
}

/// One-line key description for the report footer.
pub fn columnar_key_label() -> String {
    format!("columnar <{}>", COLUMNAR_KEY_KIND)
}
