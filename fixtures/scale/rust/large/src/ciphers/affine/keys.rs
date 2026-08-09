/// Key material for the affine family (alphabet mapping).
pub const AFFINE_KEY_KIND: &str = "alphabet mapping";

pub fn affine_default_key() -> (u8, u8) {
    (5, 8)
}

/// One-line key description for the report footer.
pub fn affine_key_label() -> String {
    format!("affine <{}>", AFFINE_KEY_KIND)
}
