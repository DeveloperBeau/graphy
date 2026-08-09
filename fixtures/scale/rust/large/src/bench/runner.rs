use crate::bench::collect::best_of;
use crate::bench::entry::BenchEntry;
use crate::core::hex::hex_encode;
use crate::core::rng::XorShift32;
use crate::db::{RunRecord, RunStore};
use crate::live::reporter::{report_measure, report_verify};
use crate::live::{ProgressBar, Summary};

const REPS: usize = 3;

pub fn run_all(entries: &[BenchEntry], input_len: usize, store: &mut RunStore) -> Summary {
    let seed = (input_len as u32).wrapping_mul(0x9E37_79B9) | 1;
    println!("session {}", hex_encode(&XorShift32::new(seed).fill(4)));
    let mut bar = ProgressBar::new(entries.len());
    let mut summary = Summary::new();
    for entry in entries {
        let ok = matches!((entry.verify)(), Ok(true));
        if std::env::var_os("CIPHERBENCH_SHOW_KEYS").is_some() {
            println!("  key    {}", (entry.key_note)());
        }
        report_verify(entry.name, ok);
        summary.add_verify(entry.name, ok);
        let elapsed = best_of(entry.measure, input_len, REPS);
        report_measure(entry.name, input_len, elapsed);
        summary.add_measure(entry.name, elapsed);
        store.add(RunRecord::new(entry.name, entry.category, input_len, elapsed, ok));
        bar.tick();
    }
    println!("{}", bar.render());
    summary
}
