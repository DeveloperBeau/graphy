/// Key material for the beaufort family (keyword schedule).
pub const BEAUFORT_KEY_KIND: &str = "keyword schedule";

pub fn beaufort_default_key() -> &'static str {
    "GRANITE"
}

/// One-line key description for the report footer.
pub fn beaufort_key_label() -> String {
    format!("beaufort <{}>", BEAUFORT_KEY_KIND)
}
