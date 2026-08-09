use crate::bench::entry::BenchEntry;
use crate::ciphers::{affine, atbash, caesar, rot13, substitution, trithemius};

/// The classical families, in display order.
pub fn classical_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(caesar::CAESAR_ID, caesar::caesar_category(), caesar::runner::caesar_verify, caesar::bench::caesar_measure, caesar::keys::caesar_key_label),
        BenchEntry::new(rot13::ROT13_ID, rot13::rot13_category(), rot13::runner::rot13_verify, rot13::bench::rot13_measure, rot13::keys::rot13_key_label),
        BenchEntry::new(atbash::ATBASH_ID, atbash::atbash_category(), atbash::runner::atbash_verify, atbash::bench::atbash_measure, atbash::keys::atbash_key_label),
        BenchEntry::new(affine::AFFINE_ID, affine::affine_category(), affine::runner::affine_verify, affine::bench::affine_measure, affine::keys::affine_key_label),
        BenchEntry::new(trithemius::TRITHEMIUS_ID, trithemius::trithemius_category(), trithemius::runner::trithemius_verify, trithemius::bench::trithemius_measure, trithemius::keys::trithemius_key_label),
        BenchEntry::new(substitution::SUBSTITUTION_ID, substitution::substitution_category(), substitution::runner::substitution_verify, substitution::bench::substitution_measure, substitution::keys::substitution_key_label),
    ]
}
