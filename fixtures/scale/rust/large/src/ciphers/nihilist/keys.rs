/// Key material for the nihilist family (keyword schedule).
pub const NIHILIST_KEY_KIND: &str = "keyword schedule";

pub fn nihilist_default_key() -> &'static str {
    "ZEBRAS"
}

/// One-line key description for the report footer.
pub fn nihilist_key_label() -> String {
    format!("nihilist <{}>", NIHILIST_KEY_KIND)
}
