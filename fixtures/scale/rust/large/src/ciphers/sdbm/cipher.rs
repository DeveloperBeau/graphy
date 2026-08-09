/// The sdbm database hash: h = c + (h << 6) + (h << 16) - h.
pub fn sdbm_digest(data: &[u8], seed: u64) -> u64 {
    let mut hash = seed;
    for &byte in data {
        hash = (byte as u64)
            .wrapping_add(hash << 6)
            .wrapping_add(hash << 16)
            .wrapping_sub(hash);
    }
    hash
}
