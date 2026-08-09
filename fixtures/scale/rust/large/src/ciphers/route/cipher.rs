/// Route cipher reading columns in a boustrophedon (snake) path.
pub fn route_encrypt(text: &str, width: usize) -> String {
    let mut chars: Vec<char> = text.chars().collect();
    while chars.len() % width != 0 {
        chars.push('X');
    }
    let height = chars.len() / width;
    let mut out = String::with_capacity(chars.len());
    for col in 0..width {
        let rows: Vec<usize> = if col % 2 == 0 {
            (0..height).collect()
        } else {
            (0..height).rev().collect()
        };
        for row in rows {
            out.push(chars[row * width + col]);
        }
    }
    out
}

pub fn route_decrypt(text: &str, width: usize) -> String {
    let chars: Vec<char> = text.chars().collect();
    let height = chars.len() / width.max(1);
    let mut grid = vec!['X'; chars.len()];
    let mut cursor = 0;
    for col in 0..width {
        let rows: Vec<usize> = if col % 2 == 0 {
            (0..height).collect()
        } else {
            (0..height).rev().collect()
        };
        for row in rows {
            grid[row * width + col] = chars[cursor];
            cursor += 1;
        }
    }
    grid.into_iter().collect()
}
