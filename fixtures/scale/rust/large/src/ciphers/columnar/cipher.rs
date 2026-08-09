/// Columnar transposition with an explicit column read order.
pub fn columnar_encrypt(text: &str, order: &[usize]) -> String {
    let width = order.len();
    let chars: Vec<char> = pad_to_width(text, width);
    let mut out = String::with_capacity(chars.len());
    for &col in order {
        let mut row = 0;
        while row * width + col < chars.len() {
            out.push(chars[row * width + col]);
            row += 1;
        }
    }
    out
}

pub fn columnar_decrypt(text: &str, order: &[usize]) -> String {
    let width = order.len();
    let chars: Vec<char> = text.chars().collect();
    let height = chars.len() / width;
    let mut grid = vec!['X'; chars.len()];
    let mut cursor = 0;
    for &col in order {
        for row in 0..height {
            grid[row * width + col] = chars[cursor];
            cursor += 1;
        }
    }
    grid.into_iter().collect()
}

fn pad_to_width(text: &str, width: usize) -> Vec<char> {
    let mut chars: Vec<char> = text.chars().collect();
    while chars.len() % width != 0 {
        chars.push('X');
    }
    chars
}
