const HEX_DIGITS: &[u8; 16] = b"0123456789abcdef";

/// Lowercase hex, used for the per-run session id in the live output.
pub fn hex_encode(data: &[u8]) -> String {
    let mut out = String::with_capacity(data.len() * 2);
    for &byte in data {
        out.push(HEX_DIGITS[(byte >> 4) as usize] as char);
        out.push(HEX_DIGITS[(byte & 0x0f) as usize] as char);
    }
    out
}
