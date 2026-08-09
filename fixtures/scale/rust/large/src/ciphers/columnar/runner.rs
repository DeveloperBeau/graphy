use crate::ciphers::columnar::cipher::{columnar_decrypt, columnar_encrypt};
use crate::ciphers::columnar::keys::columnar_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the columnar family.
pub fn columnar_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = columnar_default_key();
    let sealed = columnar_encrypt(&plain, key);
    let opened = columnar_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
