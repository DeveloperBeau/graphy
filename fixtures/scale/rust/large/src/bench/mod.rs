pub mod collect;
pub mod entry;
pub mod runner;

pub mod registry_block;
pub mod registry_classical;
pub mod registry_hash;
pub mod registry_poly;
pub mod registry_stream;
pub mod registry_trans;

use entry::BenchEntry;

/// Every registered cipher family, in display order.
pub fn registry() -> Vec<BenchEntry> {
    let mut entries = registry_classical::classical_entries();
    entries.extend(registry_poly::poly_entries());
    entries.extend(registry_trans::trans_entries());
    entries.extend(registry_stream::stream_entries());
    entries.extend(registry_block::block_entries());
    entries.extend(registry_hash::hash_entries());
    debug_assert_eq!(entries.len(), crate::ciphers::FAMILY_COUNT);
    entries
}
