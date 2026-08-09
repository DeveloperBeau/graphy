use crate::bench::entry::BenchEntry;
use crate::ciphers::{lcg_stream, rc4, salsa_lite, xor_stream};

/// The stream families, in display order.
pub fn stream_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(xor_stream::XOR_STREAM_ID, xor_stream::xor_stream_category(), xor_stream::runner::xor_stream_verify, xor_stream::bench::xor_stream_measure, xor_stream::keys::xor_stream_key_label),
        BenchEntry::new(rc4::RC4_ID, rc4::rc4_category(), rc4::runner::rc4_verify, rc4::bench::rc4_measure, rc4::keys::rc4_key_label),
        BenchEntry::new(lcg_stream::LCG_STREAM_ID, lcg_stream::lcg_stream_category(), lcg_stream::runner::lcg_stream_verify, lcg_stream::bench::lcg_stream_measure, lcg_stream::keys::lcg_stream_key_label),
        BenchEntry::new(salsa_lite::SALSA_LITE_ID, salsa_lite::salsa_lite_category(), salsa_lite::runner::salsa_lite_verify, salsa_lite::bench::salsa_lite_measure, salsa_lite::keys::salsa_lite_key_label),
    ]
}
