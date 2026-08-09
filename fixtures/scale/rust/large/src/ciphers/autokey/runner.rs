use crate::ciphers::autokey::cipher::{autokey_decrypt, autokey_encrypt};
use crate::ciphers::autokey::keys::autokey_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the autokey family.
pub fn autokey_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = autokey_default_key();
    let sealed = autokey_encrypt(&plain, key);
    let opened = autokey_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
