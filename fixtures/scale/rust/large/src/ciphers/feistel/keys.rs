/// Key material for the feistel family (round-key schedule).
pub const FEISTEL_KEY_KIND: &str = "round-key schedule";

pub fn feistel_default_key() -> u32 {
    0x5EED_CAFE
}

/// One-line key description for the report footer.
pub fn feistel_key_label() -> String {
    format!("feistel <{}>", FEISTEL_KEY_KIND)
}
