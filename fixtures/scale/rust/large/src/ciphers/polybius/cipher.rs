use crate::core::textenc::{polybius_coord, polybius_letter};

/// Each letter becomes its two-digit square coordinate.
pub fn polybius_encrypt(text: &str, _unused: u8) -> String {
    text.chars()
        .map(|c| polybius_coord(c).to_string())
        .collect::<Vec<_>>()
        .join(" ")
}

pub fn polybius_decrypt(text: &str, _unused: u8) -> String {
    text.split_whitespace()
        .map(|tok| polybius_letter(tok.parse().unwrap_or(11)))
        .collect()
}
