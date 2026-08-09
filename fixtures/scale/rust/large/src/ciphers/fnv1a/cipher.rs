const FNV_PRIME: u64 = 0x0000_0100_0000_01b3;

/// 64-bit FNV-1a fold over the input bytes.
pub fn fnv1a_digest(data: &[u8], basis: u64) -> u64 {
    let mut hash = basis;
    for &byte in data {
        hash ^= byte as u64;
        hash = hash.wrapping_mul(FNV_PRIME);
    }
    hash
}
