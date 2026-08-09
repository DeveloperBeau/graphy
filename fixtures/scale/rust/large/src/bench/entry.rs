use crate::core::errors::CipherError;

/// One benchmarkable cipher family: a self-check plus a timed run.
pub struct BenchEntry {
    pub name: &'static str,
    pub category: &'static str,
    pub verify: fn() -> Result<bool, CipherError>,
    pub measure: fn(usize) -> u128,
    pub key_note: fn() -> String,
}

impl BenchEntry {
    pub fn new(
        name: &'static str,
        category: &'static str,
        verify: fn() -> Result<bool, CipherError>,
        measure: fn(usize) -> u128,
        key_note: fn() -> String,
    ) -> Self {
        BenchEntry { name, category, verify, measure, key_note }
    }
}
