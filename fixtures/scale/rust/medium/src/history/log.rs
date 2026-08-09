use crate::history::entry::HistoryEntry;
use crate::history::DEFAULT_SHOWN;

pub struct HistoryLog {
    entries: Vec<HistoryEntry>,
    limit: usize,
}

impl HistoryLog {
    pub fn with_limit(limit: usize) -> Self {
        HistoryLog { entries: Vec::new(), limit }
    }

    pub fn push(&mut self, entry: HistoryEntry) {
        if self.entries.len() == self.limit {
            self.entries.remove(0);
        }
        self.entries.push(entry);
    }

    pub fn recent(&self) -> Vec<String> {
        let start = self.entries.len().saturating_sub(DEFAULT_SHOWN);
        self.entries[start..].iter().map(HistoryEntry::summary).collect()
    }

    pub fn len(&self) -> usize {
        self.entries.len()
    }

    pub fn is_empty(&self) -> bool {
        self.entries.is_empty()
    }
}
