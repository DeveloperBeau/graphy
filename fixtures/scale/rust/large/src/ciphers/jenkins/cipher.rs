/// Jenkins one-at-a-time hash.
pub fn jenkins_digest(data: &[u8], seed: u64) -> u64 {
    let mut hash = seed as u32;
    for &byte in data {
        hash = hash.wrapping_add(byte as u32);
        hash = hash.wrapping_add(hash << 10);
        hash ^= hash >> 6;
    }
    hash = hash.wrapping_add(hash << 3);
    hash ^= hash >> 11;
    hash = hash.wrapping_add(hash << 15);
    hash as u64
}
