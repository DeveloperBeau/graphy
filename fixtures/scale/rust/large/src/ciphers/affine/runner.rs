use crate::ciphers::affine::cipher::{affine_decrypt, affine_encrypt};
use crate::ciphers::affine::keys::affine_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the affine family.
pub fn affine_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = affine_default_key();
    let sealed = affine_encrypt(&plain, key);
    let opened = affine_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
