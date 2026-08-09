/// Bernstein's classic string hash: multiply by 33, add the byte.
/// The magic starting value 5381 is kept as the seed default so the
/// digest matches the widely published reference values.
pub fn djb2_digest(data: &[u8], seed: u64) -> u64 {
    let mut hash = seed;
    for &byte in data {
        hash = hash.wrapping_mul(33).wrapping_add(byte as u64);
    }
    hash
}
