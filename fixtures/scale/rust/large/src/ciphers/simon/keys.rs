/// Key material for the simon family (round-key schedule).
pub const SIMON_KEY_KIND: &str = "round-key schedule";

pub fn simon_default_key() -> [u32; 4] {
    [0x1918_1110, 0x0908_0100, 0x2322_2120, 0x3332_3130]
}

/// One-line key description for the report footer.
pub fn simon_key_label() -> String {
    format!("simon <{}>", SIMON_KEY_KIND)
}
