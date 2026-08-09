use crate::ciphers::pearson::cipher::pearson_digest;
use crate::ciphers::pearson::keys::pearson_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn pearson_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = pearson_default_key();
    let first = pearson_digest(&data, seed);
    let second = pearson_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && pearson_digest(&tweaked, seed) != first)
}
