use crate::bench::entry::BenchEntry;
use crate::ciphers::{feistel, simon, speck, tea, xtea};

/// The block families, in display order.
pub fn block_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(tea::TEA_ID, tea::tea_category(), tea::runner::tea_verify, tea::bench::tea_measure, tea::keys::tea_key_label),
        BenchEntry::new(xtea::XTEA_ID, xtea::xtea_category(), xtea::runner::xtea_verify, xtea::bench::xtea_measure, xtea::keys::xtea_key_label),
        BenchEntry::new(feistel::FEISTEL_ID, feistel::feistel_category(), feistel::runner::feistel_verify, feistel::bench::feistel_measure, feistel::keys::feistel_key_label),
        BenchEntry::new(speck::SPECK_ID, speck::speck_category(), speck::runner::speck_verify, speck::bench::speck_measure, speck::keys::speck_key_label),
        BenchEntry::new(simon::SIMON_ID, simon::simon_category(), simon::runner::simon_verify, simon::bench::simon_measure, simon::keys::simon_key_label),
    ]
}
