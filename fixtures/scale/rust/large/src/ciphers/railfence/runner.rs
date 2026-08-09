use crate::ciphers::railfence::cipher::{railfence_decrypt, railfence_encrypt};
use crate::ciphers::railfence::keys::railfence_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the railfence family.
pub fn railfence_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = railfence_default_key();
    let sealed = railfence_encrypt(&plain, key);
    let opened = railfence_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
