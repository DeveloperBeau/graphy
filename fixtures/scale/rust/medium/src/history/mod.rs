pub mod entry;
pub mod log;

pub use entry::HistoryEntry;
pub use log::HistoryLog;

/// How many entries the `:history` command shows by default.
pub const DEFAULT_SHOWN: usize = 10;

/// Cap a configured history limit to something sane.
pub fn clamp_limit(limit: usize) -> usize {
    limit.clamp(DEFAULT_SHOWN, 10_000)
}
