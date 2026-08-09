/// Key material for the xtea family (round-key schedule).
pub const XTEA_KEY_KIND: &str = "round-key schedule";

pub fn xtea_default_key() -> [u32; 4] {
    [0x1B2C_3D4E, 0x5F60_718A, 0x9BAC_BDCE, 0xDFE0_F102]
}

/// One-line key description for the report footer.
pub fn xtea_key_label() -> String {
    format!("xtea <{}>", XTEA_KEY_KIND)
}
