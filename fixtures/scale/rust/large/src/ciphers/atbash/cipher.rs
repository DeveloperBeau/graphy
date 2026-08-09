use crate::core::textenc::{index_letter, letter_index};

/// Mirror substitution: A<->Z, B<->Y, and so on. Self-inverse.
pub fn atbash_apply(text: &str) -> String {
    text.chars()
        .map(|c| index_letter(25 - letter_index(c)))
        .collect()
}

pub fn atbash_encrypt(text: &str, _unused: u8) -> String {
    atbash_apply(text)
}

pub fn atbash_decrypt(text: &str, _unused: u8) -> String {
    atbash_apply(text)
}
