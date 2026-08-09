use crate::ciphers::polybius::cipher::{polybius_decrypt, polybius_encrypt};
use crate::ciphers::polybius::keys::polybius_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the polybius family.
pub fn polybius_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = polybius_default_key();
    let sealed = polybius_encrypt(&plain, key);
    let opened = polybius_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
