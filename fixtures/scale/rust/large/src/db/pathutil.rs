use std::path::{Path, PathBuf};

/// Where run results land unless CIPHERBENCH_DB overrides it.
pub fn default_db_path() -> PathBuf {
    match std::env::var_os("CIPHERBENCH_DB") {
        Some(custom) => PathBuf::from(custom),
        None => PathBuf::from("cipherbench-runs.csv"),
    }
}

pub fn ensure_parent(path: &Path) -> std::io::Result<()> {
    if let Some(parent) = path.parent() {
        if !parent.as_os_str().is_empty() {
            std::fs::create_dir_all(parent)?;
        }
    }
    Ok(())
}
