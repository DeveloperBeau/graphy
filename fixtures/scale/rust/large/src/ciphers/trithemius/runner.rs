use crate::ciphers::trithemius::cipher::{trithemius_decrypt, trithemius_encrypt};
use crate::ciphers::trithemius::keys::trithemius_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the trithemius family.
pub fn trithemius_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = trithemius_default_key();
    let sealed = trithemius_encrypt(&plain, key);
    let opened = trithemius_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
