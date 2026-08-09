use crate::core::textenc::{index_letter, letter_index};

/// Reciprocal tableau cipher: encryption and decryption coincide.
pub fn beaufort_apply(text: &str, key: &str) -> String {
    let shifts: Vec<u8> = key.chars().map(letter_index).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| {
            let k = shifts[i % shifts.len()];
            index_letter((k + 26 - letter_index(c)) % 26)
        })
        .collect()
}

pub fn beaufort_encrypt(text: &str, key: &str) -> String {
    beaufort_apply(text, key)
}

pub fn beaufort_decrypt(text: &str, key: &str) -> String {
    beaufort_apply(text, key)
}
