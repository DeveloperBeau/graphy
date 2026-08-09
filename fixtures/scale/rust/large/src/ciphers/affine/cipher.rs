use crate::core::textenc::{index_letter, letter_index};

pub fn affine_encrypt(text: &str, key: (u8, u8)) -> String {
    let (a, b) = key;
    text.chars()
        .map(|c| index_letter((letter_index(c) * a + b) % 26))
        .collect()
}

pub fn affine_decrypt(text: &str, key: (u8, u8)) -> String {
    let (a, b) = key;
    let inv = affine_inverse(a) as u16;
    let undo = (26 - b % 26) as u16;
    text.chars()
        .map(|c| index_letter(((inv * (letter_index(c) as u16 + undo)) % 26) as u8))
        .collect()
}

/// Multiplicative inverse of `a` modulo 26, by trial: the alphabet is
/// small enough that scanning beats extended Euclid for clarity.
fn affine_inverse(a: u8) -> u8 {
    (1..26).find(|i| (a as u16 * *i as u16) % 26 == 1).unwrap_or(1) as u8
}
