use crate::core::textenc::{index_letter, letter_index};

/// Porta's reciprocal digraphic tableau, in arithmetic form.
pub fn porta_apply(text: &str, key: &str) -> String {
    let rows: Vec<u8> = key.chars().map(|c| letter_index(c) / 2).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| {
            let row = rows[i % rows.len()];
            let x = letter_index(c);
            if x < 13 {
                index_letter(13 + (x + row) % 13)
            } else {
                index_letter((x + 13 - row) % 13)
            }
        })
        .collect()
}

pub fn porta_encrypt(text: &str, key: &str) -> String {
    porta_apply(text, key)
}

pub fn porta_decrypt(text: &str, key: &str) -> String {
    porta_apply(text, key)
}
