pub mod csvio;
pub mod pathutil;
pub mod record;
pub mod store;

pub use record::RunRecord;
pub use store::RunStore;

/// Bumped whenever `RunRecord::csv_line` changes shape.
pub const DB_VERSION: u32 = 2;

pub fn schema_header() -> &'static str {
    "family,op,bytes,elapsed_ns,ok"
}
