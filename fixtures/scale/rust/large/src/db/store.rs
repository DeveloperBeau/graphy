use crate::core::errors::CipherError;
use crate::db::csvio::{parse_record, write_records};
use crate::db::pathutil::ensure_parent;
use crate::db::record::RunRecord;
use std::path::PathBuf;

pub struct RunStore {
    path: PathBuf,
    records: Vec<RunRecord>,
}

impl RunStore {
    pub fn new(path: PathBuf) -> Self {
        RunStore { path, records: Vec::new() }
    }

    pub fn add(&mut self, record: RunRecord) {
        self.records.push(record);
    }

    pub fn len(&self) -> usize {
        self.records.len()
    }

    pub fn save(&self) -> Result<(), CipherError> {
        ensure_parent(&self.path)?;
        write_records(&self.path, &self.records)?;
        Ok(())
    }

    pub fn load(path: &PathBuf) -> Vec<RunRecord> {
        let Ok(text) = std::fs::read_to_string(path) else {
            return Vec::new();
        };
        text.lines().skip(2).filter_map(parse_record).collect()
    }
}
