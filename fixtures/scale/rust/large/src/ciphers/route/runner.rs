use crate::ciphers::route::cipher::{route_decrypt, route_encrypt};
use crate::ciphers::route::keys::route_default_key;
use crate::core::errors::CipherError;
use crate::core::sample::sample_text;
use crate::core::textenc::only_letters;

/// Round-trip the shared corpus through the route family.
pub fn route_verify() -> Result<bool, CipherError> {
    let plain = only_letters(sample_text());
    if plain.is_empty() {
        return Err(CipherError::BadInput("sample corpus is empty"));
    }
    let key = route_default_key();
    let sealed = route_encrypt(&plain, key);
    let opened = route_decrypt(&sealed, key);
    Ok(opened.trim_end_matches('X') == plain)
}
