use crate::ciphers::beaufort::cipher::{beaufort_decrypt, beaufort_encrypt};
use crate::ciphers::beaufort::keys::beaufort_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the beaufort family.
pub fn beaufort_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = beaufort_default_key();
    let sealed = beaufort_encrypt(&plain, key);
    let opened = beaufort_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
