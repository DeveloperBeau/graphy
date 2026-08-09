use crate::ciphers::crc32::cipher::crc32_digest;
use crate::ciphers::crc32::keys::crc32_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn crc32_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = crc32_default_key();
    let first = crc32_digest(&data, seed);
    let second = crc32_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && crc32_digest(&tweaked, seed) != first)
}
