use crate::ciphers::scytale::cipher::{scytale_decrypt, scytale_encrypt};
use crate::ciphers::scytale::keys::scytale_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the scytale family.
pub fn scytale_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = scytale_default_key();
    let sealed = scytale_encrypt(&plain, key);
    let opened = scytale_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
