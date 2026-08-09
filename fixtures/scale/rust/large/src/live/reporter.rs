use crate::core::stats::{format_ns, throughput_mbps};

pub fn report_verify(family: &str, ok: bool) {
    let mark = if ok { "ok" } else { "FAIL" };
    println!("  verify {family:<14} {mark}");
}

pub fn report_measure(family: &str, input_len: usize, elapsed_ns: u128) {
    println!(
        "  bench  {family:<14} {} ({:.1} MB/s)",
        format_ns(elapsed_ns),
        throughput_mbps(input_len, elapsed_ns)
    );
}
