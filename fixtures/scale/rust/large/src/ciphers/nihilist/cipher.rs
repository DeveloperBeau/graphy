use crate::core::textenc::polybius_coord;

/// Polybius coordinates plus a repeating keyword offset, rendered as
/// space-separated numbers.
pub fn nihilist_encrypt(text: &str, key: &str) -> String {
    let adds: Vec<u16> = key.chars().map(polybius_coord).collect();
    text.chars()
        .enumerate()
        .map(|(i, c)| (polybius_coord(c) + adds[i % adds.len()]).to_string())
        .collect::<Vec<_>>()
        .join(" ")
}

pub fn nihilist_decrypt(text: &str, key: &str) -> String {
    let adds: Vec<u16> = key.chars().map(polybius_coord).collect();
    text.split_whitespace()
        .enumerate()
        .map(|(i, tok)| {
            let n: u16 = tok.parse().unwrap_or(11);
            crate::core::textenc::polybius_letter(n - adds[i % adds.len()])
        })
        .collect()
}
