/// Zigzag transposition across `rails` rows.
pub fn railfence_encrypt(text: &str, rails: usize) -> String {
    let mut rows = vec![String::new(); rails];
    for (i, c) in text.chars().enumerate() {
        rows[rail_for(i, rails)].push(c);
    }
    rows.concat()
}

pub fn railfence_decrypt(text: &str, rails: usize) -> String {
    let len = text.chars().count();
    let mut counts = vec![0usize; rails];
    for i in 0..len {
        counts[rail_for(i, rails)] += 1;
    }
    let mut rows: Vec<Vec<char>> = Vec::new();
    let mut it = text.chars();
    for count in counts {
        rows.push((0..count).filter_map(|_| it.next()).collect());
    }
    let mut cursors = vec![0usize; rails];
    (0..len)
        .map(|i| {
            let r = rail_for(i, rails);
            cursors[r] += 1;
            rows[r][cursors[r] - 1]
        })
        .collect()
}

fn rail_for(i: usize, rails: usize) -> usize {
    let cycle = 2 * rails - 2;
    let pos = i % cycle;
    if pos < rails { pos } else { cycle - pos }
}
