use crate::core::textenc::{index_letter, letter_index};

/// Fixed-shift substitution over the uppercase alphabet.
pub fn caesar_encrypt(text: &str, shift: u8) -> String {
    text.chars()
        .map(|c| index_letter((letter_index(c) + shift) % 26))
        .collect()
}

pub fn caesar_decrypt(text: &str, shift: u8) -> String {
    caesar_encrypt(text, (26 - shift % 26) % 26)
}
