use crate::core::textenc::{index_letter, letter_index};

/// Vigenere variant where the plaintext itself extends the key.
pub fn autokey_encrypt(text: &str, key: &str) -> String {
    let stream: Vec<u8> = key.chars().chain(text.chars()).map(letter_index).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| index_letter((letter_index(c) + stream[i]) % 26))
        .collect()
}

pub fn autokey_decrypt(text: &str, key: &str) -> String {
    let mut stream: Vec<u8> = key.chars().map(letter_index).collect();
    let mut out = String::with_capacity(text.len());
    for (i, c) in text.chars().enumerate() {
        let plain = (letter_index(c) + 26 - stream[i]) % 26;
        stream.push(plain);
        out.push(index_letter(plain));
    }
    out
}
