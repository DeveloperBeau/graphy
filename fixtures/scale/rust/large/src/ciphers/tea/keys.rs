/// Key material for the tea family (round-key schedule).
pub const TEA_KEY_KIND: &str = "round-key schedule";

pub fn tea_default_key() -> [u32; 4] {
    [0x0123_4567, 0x89AB_CDEF, 0xFEDC_BA98, 0x7654_3210]
}

/// One-line key description for the report footer.
pub fn tea_key_label() -> String {
    format!("tea <{}>", TEA_KEY_KIND)
}
