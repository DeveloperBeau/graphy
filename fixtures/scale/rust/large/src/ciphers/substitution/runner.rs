use crate::ciphers::substitution::cipher::{substitution_decrypt, substitution_encrypt};
use crate::ciphers::substitution::keys::substitution_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the substitution family.
pub fn substitution_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = substitution_default_key();
    let sealed = substitution_encrypt(&plain, key);
    let opened = substitution_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
