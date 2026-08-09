const MOD_ADLER: u64 = 65_521;

/// Adler-32 checksum as used by zlib, widened to u64 for the common
/// digest signature shared by the hash families.
pub fn adler32_digest(data: &[u8], seed: u64) -> u64 {
    let mut a = seed % MOD_ADLER;
    let mut b = 0u64;
    for &byte in data {
        a = (a + byte as u64) % MOD_ADLER;
        b = (b + a) % MOD_ADLER;
    }
    (b << 16) | a
}
