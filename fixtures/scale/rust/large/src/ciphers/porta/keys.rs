/// Key material for the porta family (keyword schedule).
pub const PORTA_KEY_KIND: &str = "keyword schedule";

pub fn porta_default_key() -> &'static str {
    "MERCURY"
}

/// One-line key description for the report footer.
pub fn porta_key_label() -> String {
    format!("porta <{}>", PORTA_KEY_KIND)
}
