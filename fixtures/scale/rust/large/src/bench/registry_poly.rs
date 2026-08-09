use crate::bench::entry::BenchEntry;
use crate::ciphers::{autokey, beaufort, gronsfeld, nihilist, porta, vigenere};

/// The poly families, in display order.
pub fn poly_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(vigenere::VIGENERE_ID, vigenere::vigenere_category(), vigenere::runner::vigenere_verify, vigenere::bench::vigenere_measure, vigenere::keys::vigenere_key_label),
        BenchEntry::new(autokey::AUTOKEY_ID, autokey::autokey_category(), autokey::runner::autokey_verify, autokey::bench::autokey_measure, autokey::keys::autokey_key_label),
        BenchEntry::new(beaufort::BEAUFORT_ID, beaufort::beaufort_category(), beaufort::runner::beaufort_verify, beaufort::bench::beaufort_measure, beaufort::keys::beaufort_key_label),
        BenchEntry::new(gronsfeld::GRONSFELD_ID, gronsfeld::gronsfeld_category(), gronsfeld::runner::gronsfeld_verify, gronsfeld::bench::gronsfeld_measure, gronsfeld::keys::gronsfeld_key_label),
        BenchEntry::new(porta::PORTA_ID, porta::porta_category(), porta::runner::porta_verify, porta::bench::porta_measure, porta::keys::porta_key_label),
        BenchEntry::new(nihilist::NIHILIST_ID, nihilist::nihilist_category(), nihilist::runner::nihilist_verify, nihilist::bench::nihilist_measure, nihilist::keys::nihilist_key_label),
    ]
}
