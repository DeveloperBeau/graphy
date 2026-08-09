/// Key material for the speck family (round-key schedule).
pub const SPECK_KEY_KIND: &str = "round-key schedule";

pub fn speck_default_key() -> [u32; 4] {
    [0x0302_0100, 0x0b0a_0908, 0x1312_1110, 0x1b1a_1918]
}

/// One-line key description for the report footer.
pub fn speck_key_label() -> String {
    format!("speck <{}>", SPECK_KEY_KIND)
}
