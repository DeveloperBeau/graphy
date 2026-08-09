use crate::ciphers::porta::cipher::{porta_decrypt, porta_encrypt};
use crate::ciphers::porta::keys::porta_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the porta family.
pub fn porta_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = porta_default_key();
    let sealed = porta_encrypt(&plain, key);
    let opened = porta_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
