use crate::core::textenc::{index_letter, letter_index};

/// Vigenere with a numeric key, one digit of shift per position.
pub fn gronsfeld_encrypt(text: &str, digits: &[u8]) -> String {
    text.chars()
        .enumerate()
        .map(|(i, c)| index_letter((letter_index(c) + digits[i % digits.len()]) % 26))
        .collect()
}

pub fn gronsfeld_decrypt(text: &str, digits: &[u8]) -> String {
    text.chars()
        .enumerate()
        .map(|(i, c)| {
            let d = digits[i % digits.len()];
            index_letter((letter_index(c) + 26 - d) % 26)
        })
        .collect()
}
