use crate::ciphers::adler32::cipher::adler32_digest;
use crate::ciphers::adler32::keys::adler32_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn adler32_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = adler32_default_key();
    let first = adler32_digest(&data, seed);
    let second = adler32_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && adler32_digest(&tweaked, seed) != first)
}
