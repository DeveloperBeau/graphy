/// Key material for the salsa_lite family (keystream seed).
pub const SALSA_LITE_KEY_KIND: &str = "keystream seed";

pub fn salsa_lite_default_key() -> [u32; 4] {
    [0x6170_7865, 0x3320_646e, 0x7962_2d32, 0x6b20_6574]
}

/// One-line key description for the report footer.
pub fn salsa_lite_key_label() -> String {
    format!("salsa_lite <{}>", SALSA_LITE_KEY_KIND)
}
