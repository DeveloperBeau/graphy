use crate::bench::entry::BenchEntry;
use crate::ciphers::{bifid, columnar, polybius, railfence, route, scytale};

/// The trans families, in display order.
pub fn trans_entries() -> Vec<BenchEntry> {
    vec![
        BenchEntry::new(polybius::POLYBIUS_ID, polybius::polybius_category(), polybius::runner::polybius_verify, polybius::bench::polybius_measure, polybius::keys::polybius_key_label),
        BenchEntry::new(bifid::BIFID_ID, bifid::bifid_category(), bifid::runner::bifid_verify, bifid::bench::bifid_measure, bifid::keys::bifid_key_label),
        BenchEntry::new(railfence::RAILFENCE_ID, railfence::railfence_category(), railfence::runner::railfence_verify, railfence::bench::railfence_measure, railfence::keys::railfence_key_label),
        BenchEntry::new(columnar::COLUMNAR_ID, columnar::columnar_category(), columnar::runner::columnar_verify, columnar::bench::columnar_measure, columnar::keys::columnar_key_label),
        BenchEntry::new(scytale::SCYTALE_ID, scytale::scytale_category(), scytale::runner::scytale_verify, scytale::bench::scytale_measure, scytale::keys::scytale_key_label),
        BenchEntry::new(route::ROUTE_ID, route::route_category(), route::runner::route_verify, route::bench::route_measure, route::keys::route_key_label),
    ]
}
