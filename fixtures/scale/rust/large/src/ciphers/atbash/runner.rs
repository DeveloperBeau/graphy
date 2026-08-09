use crate::ciphers::atbash::cipher::{atbash_decrypt, atbash_encrypt};
use crate::ciphers::atbash::keys::atbash_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the atbash family.
pub fn atbash_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = atbash_default_key();
    let sealed = atbash_encrypt(&plain, key);
    let opened = atbash_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
