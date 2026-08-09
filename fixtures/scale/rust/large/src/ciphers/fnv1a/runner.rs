use crate::ciphers::fnv1a::cipher::fnv1a_digest;
use crate::ciphers::fnv1a::keys::fnv1a_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn fnv1a_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = fnv1a_default_key();
    let first = fnv1a_digest(&data, seed);
    let second = fnv1a_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && fnv1a_digest(&tweaked, seed) != first)
}
