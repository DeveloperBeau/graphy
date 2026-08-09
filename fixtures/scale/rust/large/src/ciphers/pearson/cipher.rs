/// Pearson hashing over a seed-shuffled permutation table, folded to
/// eight output bytes.
fn pearson_table(seed: u64) -> [u8; 256] {
    let mut table = [0u8; 256];
    for (i, slot) in table.iter_mut().enumerate() {
        *slot = i as u8;
    }
    let mut state = seed as u32 | 1;
    for i in (1..256usize).rev() {
        state = state.wrapping_mul(1_664_525).wrapping_add(1_013_904_223);
        table.swap(i, (state as usize) % (i + 1));
    }
    table
}

pub fn pearson_digest(data: &[u8], seed: u64) -> u64 {
    let table = pearson_table(seed);
    let mut out = 0u64;
    for lane in 0..8u8 {
        let mut h = table[lane as usize];
        for &byte in data {
            h = table[(h ^ byte) as usize];
        }
        out = (out << 8) | h as u64;
    }
    out
}
