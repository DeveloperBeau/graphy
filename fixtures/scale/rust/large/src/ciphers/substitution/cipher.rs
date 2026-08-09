use crate::core::textenc::{index_letter, letter_index};

pub fn substitution_encrypt(text: &str, alphabet: &[u8; 26]) -> String {
    text.chars()
        .map(|c| alphabet[letter_index(c) as usize] as char)
        .collect()
}

pub fn substitution_decrypt(text: &str, alphabet: &[u8; 26]) -> String {
    text.chars()
        .map(|c| {
            let pos = alphabet.iter().position(|&x| x == c as u8).unwrap_or(0);
            index_letter(pos as u8)
        })
        .collect()
}
