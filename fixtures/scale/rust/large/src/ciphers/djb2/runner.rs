use crate::ciphers::djb2::cipher::djb2_digest;
use crate::ciphers::djb2::keys::djb2_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn djb2_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = djb2_default_key();
    let first = djb2_digest(&data, seed);
    let second = djb2_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && djb2_digest(&tweaked, seed) != first)
}
