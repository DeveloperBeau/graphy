use crate::core::textenc::{polybius_coord, polybius_letter};

/// Delastelle's fractionating cipher: rows and columns are written out
/// separately, then re-paired.
pub fn bifid_encrypt(text: &str, _unused: u8) -> String {
    let mut rows = Vec::new();
    let mut cols = Vec::new();
    for c in text.chars() {
        let coord = polybius_coord(c);
        rows.push(coord / 10);
        cols.push(coord % 10);
    }
    rows.extend(cols);
    rows.chunks(2)
        .map(|pair| polybius_letter(pair[0] * 10 + pair[1]))
        .collect()
}

pub fn bifid_decrypt(text: &str, _unused: u8) -> String {
    let flat: Vec<u16> = text
        .chars()
        .flat_map(|c| {
            let coord = polybius_coord(c);
            [coord / 10, coord % 10]
        })
        .collect();
    let half = flat.len() / 2;
    (0..half)
        .map(|i| polybius_letter(flat[i] * 10 + flat[half + i]))
        .collect()
}
