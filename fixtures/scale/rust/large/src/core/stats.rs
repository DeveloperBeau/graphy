/// Megabytes per second, given a byte count and elapsed nanoseconds.
pub fn throughput_mbps(bytes: usize, elapsed_ns: u128) -> f64 {
    if elapsed_ns == 0 {
        return 0.0;
    }
    let seconds = elapsed_ns as f64 / 1e9;
    (bytes as f64 / 1e6) / seconds
}

pub fn mean_ns(samples: &[u128]) -> f64 {
    if samples.is_empty() {
        return 0.0;
    }
    samples.iter().sum::<u128>() as f64 / samples.len() as f64
}

pub fn format_ns(elapsed_ns: u128) -> String {
    match elapsed_ns {
        0..=999 => format!("{elapsed_ns} ns"),
        1_000..=999_999 => format!("{:.1} us", elapsed_ns as f64 / 1e3),
        1_000_000..=999_999_999 => format!("{:.1} ms", elapsed_ns as f64 / 1e6),
        _ => format!("{:.2} s", elapsed_ns as f64 / 1e9),
    }
}
