use crate::core::textenc::{index_letter, letter_index};

/// Progressive Caesar: the shift grows by one per position.
pub fn trithemius_encrypt(text: &str, offset: u8) -> String {
    text.chars()
        .enumerate()
        .map(|(i, c)| index_letter((letter_index(c) + offset + (i % 26) as u8) % 26))
        .collect()
}

pub fn trithemius_decrypt(text: &str, offset: u8) -> String {
    text.chars()
        .enumerate()
        .map(|(i, c)| {
            let back = (offset + (i % 26) as u8) % 26;
            index_letter((letter_index(c) + 26 - back) % 26)
        })
        .collect()
}
