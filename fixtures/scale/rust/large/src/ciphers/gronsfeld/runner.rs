use crate::ciphers::gronsfeld::cipher::{gronsfeld_decrypt, gronsfeld_encrypt};
use crate::ciphers::gronsfeld::keys::gronsfeld_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the gronsfeld family.
pub fn gronsfeld_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = gronsfeld_default_key();
    let sealed = gronsfeld_encrypt(&plain, key);
    let opened = gronsfeld_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
