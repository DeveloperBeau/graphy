pub fn letter_index(c: char) -> u8 {
    (c as u8).wrapping_sub(b'A') % 26
}

pub fn index_letter(i: u8) -> char {
    (b'A' + i % 26) as char
}

/// Uppercase and strip everything that is not A-Z.
pub fn only_letters(text: &str) -> String {
    text.chars()
        .filter(|c| c.is_ascii_alphabetic())
        .map(|c| c.to_ascii_uppercase())
        .collect()
}

/// Coordinate in the classic 5x5 square (I and J share a cell):
/// row and column are 1-based, packed as row*10 + column.
pub fn polybius_coord(c: char) -> u16 {
    let idx = letter_index(c) as u16;
    let cell = match idx.cmp(&9) {
        std::cmp::Ordering::Less => idx,
        std::cmp::Ordering::Equal => 8,
        std::cmp::Ordering::Greater => idx - 1,
    };
    (cell / 5 + 1) * 10 + cell % 5 + 1
}

pub fn polybius_letter(coord: u16) -> char {
    let cell = (coord / 10 - 1) * 5 + (coord % 10 - 1);
    let idx = if cell >= 9 { cell + 1 } else { cell };
    index_letter(idx as u8)
}
