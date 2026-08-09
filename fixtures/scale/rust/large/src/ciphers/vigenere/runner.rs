use crate::ciphers::vigenere::cipher::{vigenere_decrypt, vigenere_encrypt};
use crate::ciphers::vigenere::keys::vigenere_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the vigenere family.
pub fn vigenere_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = vigenere_default_key();
    let sealed = vigenere_encrypt(&plain, key);
    let opened = vigenere_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
