use crate::ciphers::sdbm::cipher::sdbm_digest;
use crate::ciphers::sdbm::keys::sdbm_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn sdbm_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = sdbm_default_key();
    let first = sdbm_digest(&data, seed);
    let second = sdbm_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && sdbm_digest(&tweaked, seed) != first)
}
