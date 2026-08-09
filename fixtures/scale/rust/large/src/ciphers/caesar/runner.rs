use crate::ciphers::caesar::cipher::{caesar_decrypt, caesar_encrypt};
use crate::ciphers::caesar::keys::caesar_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the caesar family.
pub fn caesar_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = caesar_default_key();
    let sealed = caesar_encrypt(&plain, key);
    let opened = caesar_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
