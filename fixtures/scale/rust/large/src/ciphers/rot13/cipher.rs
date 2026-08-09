use crate::core::textenc::{index_letter, letter_index};

/// The classic self-inverse half-alphabet rotation.
pub fn rot13_apply(text: &str) -> String {
    text.chars()
        .map(|c| index_letter((letter_index(c) + 13) % 26))
        .collect()
}

pub fn rot13_encrypt(text: &str, _shift: u8) -> String {
    rot13_apply(text)
}

pub fn rot13_decrypt(text: &str, _shift: u8) -> String {
    rot13_apply(text)
}
