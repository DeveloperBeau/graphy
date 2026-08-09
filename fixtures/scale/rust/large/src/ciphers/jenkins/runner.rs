use crate::ciphers::jenkins::cipher::jenkins_digest;
use crate::ciphers::jenkins::keys::jenkins_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_bytes;

/// Digests must be stable for equal input and shift when a single
/// input byte changes.
pub fn jenkins_verify() -> Result<bool, CipherError> {
    let data = sample_bytes(256);
    let seed = jenkins_default_key();
    let first = jenkins_digest(&data, seed);
    let second = jenkins_digest(&data, seed);
    let mut tweaked = data.clone();
    tweaked[0] ^= 0x55;
    Ok(first == second && jenkins_digest(&tweaked, seed) != first)
}
