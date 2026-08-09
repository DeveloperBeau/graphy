use crate::ciphers::nihilist::cipher::{nihilist_decrypt, nihilist_encrypt};
use crate::ciphers::nihilist::keys::nihilist_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the nihilist family.
pub fn nihilist_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = nihilist_default_key();
    let sealed = nihilist_encrypt(&plain, key);
    let opened = nihilist_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
