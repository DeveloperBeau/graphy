use crate::ciphers::bifid::cipher::{bifid_decrypt, bifid_encrypt};
use crate::ciphers::bifid::keys::bifid_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the bifid family.
pub fn bifid_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = bifid_default_key();
    let sealed = bifid_encrypt(&plain, key);
    let opened = bifid_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
