use crate::ciphers::rot13::cipher::{rot13_decrypt, rot13_encrypt};
use crate::ciphers::rot13::keys::rot13_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the rot13 family.
pub fn rot13_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = rot13_default_key();
    let sealed = rot13_encrypt(&plain, key);
    let opened = rot13_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
