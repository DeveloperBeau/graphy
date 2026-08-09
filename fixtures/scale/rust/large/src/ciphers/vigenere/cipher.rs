use crate::core::textenc::{index_letter, letter_index};

pub fn vigenere_encrypt(text: &str, key: &str) -> String {
    let shifts: Vec<u8> = key.chars().map(letter_index).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| index_letter((letter_index(c) + shifts[i % shifts.len()]) % 26))
        .collect()
}

pub fn vigenere_decrypt(text: &str, key: &str) -> String {
    let shifts: Vec<u8> = key.chars().map(letter_index).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| {
            let s = shifts[i % shifts.len()];
            index_letter((letter_index(c) + 26 - s) % 26)
        })
        .collect()
}
