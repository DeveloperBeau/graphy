const CRC_POLY: u32 = 0xEDB8_8320;

/// Bitwise CRC-32 (no lookup table; the bench cares about the shape of
/// the loop, not raw speed).
pub fn crc32_digest(data: &[u8], seed: u64) -> u64 {
    let mut crc = seed as u32;
    for &byte in data {
        crc ^= byte as u32;
        for _ in 0..8 {
            let mask = (crc & 1).wrapping_neg();
            crc = (crc >> 1) ^ (CRC_POLY & mask);
        }
    }
    (!crc) as u64
}
