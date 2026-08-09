use crate::db::record::RunRecord;
use crate::db::{schema_header, DB_VERSION};
use std::io::Write;
use std::path::Path;

pub fn write_records(path: &Path, records: &[RunRecord]) -> std::io::Result<()> {
    let mut file = std::fs::File::create(path)?;
    writeln!(file, "# cipherbench results v{DB_VERSION}")?;
    writeln!(file, "{}", schema_header())?;
    for record in records {
        writeln!(file, "{}", record.csv_line())?;
    }
    Ok(())
}

pub fn parse_record(line: &str) -> Option<RunRecord> {
    let mut parts = line.split(',');
    Some(RunRecord {
        family: parts.next()?.to_string(),
        op: parts.next()?.to_string(),
        input_len: parts.next()?.parse().ok()?,
        elapsed_ns: parts.next()?.parse().ok()?,
        ok: parts.next()? == "true",
    })
}
