//! `.gitignore` writer for `graphy-out/`.
//!
//! Every `graphy run` ensures the workspace excludes its own build output, so
//! `graphy-out/` never lands in a diff.
//!
//! Guarantees:
//! - Creates `.gitignore` with the entry when the workspace has none;
//!   otherwise appends to the existing file.
//! - Idempotent. Re-running on a file that already excludes `graphy-out/`
//!   leaves it untouched.
//! - Recognises the existing entry whether written as `graphy-out` or
//!   `graphy-out/`, with or without leading `/`.

use std::fs;
use std::io::Write;
use std::path::Path;

use anyhow::{Context, Result};

const ENTRY: &str = "graphy-out/";

/// Ensure `<workspace>/.gitignore` excludes `graphy-out/`: append the entry to
/// an existing file, or create the file with it when absent. No-op if the entry
/// is already present.
pub fn ensure_graphy_out_excluded(workspace: &Path) -> Result<()> {
    let gitignore = workspace.join(".gitignore");
    if !gitignore.exists() {
        fs::write(&gitignore, format!("{ENTRY}\n"))
            .with_context(|| format!("create {}", gitignore.display()))?;
        return Ok(());
    }
    let existing = fs::read_to_string(&gitignore)
        .with_context(|| format!("read {}", gitignore.display()))?;
    if has_entry(&existing) {
        return Ok(());
    }
    let mut file = fs::OpenOptions::new()
        .append(true)
        .open(&gitignore)
        .with_context(|| format!("open {} for append", gitignore.display()))?;
    let needs_newline = !existing.is_empty() && !existing.ends_with('\n');
    if needs_newline {
        writeln!(file)?;
    }
    writeln!(file, "{ENTRY}")?;
    Ok(())
}

fn has_entry(contents: &str) -> bool {
    contents.lines().any(|raw| {
        let line = raw.trim();
        if line.is_empty() || line.starts_with('#') {
            return false;
        }
        let normalised = line.trim_start_matches('/').trim_end_matches('/');
        normalised == "graphy-out"
    })
}

#[cfg(test)]
mod tests {
    use super::*;
    use tempfile::tempdir;

    #[test]
    fn missing_gitignore_is_created_with_entry() {
        let dir = tempdir().unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        let gi = dir.path().join(".gitignore");
        assert!(gi.exists());
        assert_eq!(fs::read_to_string(&gi).unwrap(), "graphy-out/\n");
    }

    #[test]
    fn appends_entry_to_existing_gitignore() {
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "target/\nnode_modules/\n").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        let out = fs::read_to_string(&gi).unwrap();
        assert!(out.contains("graphy-out/"), "{out:?}");
        assert!(out.ends_with("graphy-out/\n"), "{out:?}");
    }

    #[test]
    fn idempotent_when_entry_already_present() {
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "target/\ngraphy-out/\n").unwrap();
        let before = fs::read_to_string(&gi).unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        assert_eq!(fs::read_to_string(&gi).unwrap(), before);
    }

    #[test]
    fn recognises_entry_variants() {
        for existing in [
            "graphy-out",
            "graphy-out/",
            "/graphy-out",
            "/graphy-out/",
            "  graphy-out/  ",
        ] {
            let dir = tempdir().unwrap();
            let gi = dir.path().join(".gitignore");
            fs::write(&gi, format!("{existing}\nother\n")).unwrap();
            ensure_graphy_out_excluded(dir.path()).unwrap();
            let out = fs::read_to_string(&gi).unwrap();
            assert_eq!(
                out.matches("graphy-out").count(),
                1,
                "duplicated entry for input {existing:?}: {out:?}"
            );
        }
    }

    #[test]
    fn comment_lines_do_not_count_as_match() {
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "# graphy-out/\nother\n").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        let out = fs::read_to_string(&gi).unwrap();
        assert!(out.contains("\ngraphy-out/\n"), "{out:?}");
    }

    #[test]
    fn appends_newline_when_existing_file_has_no_trailing_newline() {
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "target/").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        assert_eq!(fs::read_to_string(&gi).unwrap(), "target/\ngraphy-out/\n");
    }
}
