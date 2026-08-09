/// Run a measure function several times and keep the best (smallest)
/// reading; wall-clock noise only ever adds time.
pub fn best_of(measure: fn(usize) -> u128, input_len: usize, reps: usize) -> u128 {
    let mut best = u128::MAX;
    for _ in 0..reps.max(1) {
        best = best.min(measure(input_len));
    }
    best
}

/// Standard sweep sizes for a full profile run.
pub fn sweep_sizes() -> Vec<usize> {
    vec![256, 1024, 4096, 16384]
}
