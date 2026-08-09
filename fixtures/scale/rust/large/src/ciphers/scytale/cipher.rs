/// The Spartan rod: wrap text around `rows` turns and read it off.
pub fn scytale_encrypt(text: &str, rows: usize) -> String {
    let mut chars: Vec<char> = text.chars().collect();
    while chars.len() % rows != 0 {
        chars.push('X');
    }
    let width = chars.len() / rows;
    let mut out = String::with_capacity(chars.len());
    for col in 0..width {
        for row in 0..rows {
            out.push(chars[row * width + col]);
        }
    }
    out
}

pub fn scytale_decrypt(text: &str, rows: usize) -> String {
    let len = text.chars().count();
    let width = len / rows.max(1);
    scytale_encrypt(text, width.max(1))
}
