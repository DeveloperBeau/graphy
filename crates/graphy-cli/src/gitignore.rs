//! Opt-in `.gitignore` writer for `graphy-out/`.
//!
//! Standalone `graphy` users may not want the CLI touching their tracked
//! files, so this is off by default and only runs when the caller exports
//! `GRAPHY_AUTO_GITIGNORE=1`. The claude-plugin's hook scripts set the
//! variable so plugin users get the convenience automatically; the CLI
//! invoked from a terminal does not.
//!
//! Guarantees:
//! - Never creates `.gitignore`. We only append to an existing file.
//! - Idempotent. Re-running on a file that already excludes `graphy-out/`
//!   leaves it untouched.
//! - Recognises the existing entry whether written as `graphy-out` or
//!   `graphy-out/`, with or without leading `/`.

use std::fs;
use std::io::Write;
use std::path::Path;

use anyhow::{Context, Result};

const ENTRY: &str = "graphy-out/";

/// If enabled, append `graphy-out/` to `<workspace>/.gitignore` when the file
/// already exists and does not contain the entry. No-op otherwise.
pub fn ensure_graphy_out_excluded(workspace: &Path) -> Result<()> {
    if std::env::var("GRAPHY_AUTO_GITIGNORE").as_deref() != Ok("1") {
        return Ok(());
    }
    let gitignore = workspace.join(".gitignore");
    if !gitignore.exists() {
        // Don't create a .gitignore unsolicited — only append to one the user
        // already owns.
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
    use std::sync::Mutex;
    use tempfile::tempdir;

    // GRAPHY_AUTO_GITIGNORE is process-global; tests must not race on it.
    static ENV_GUARD: Mutex<()> = Mutex::new(());

    struct AutoOptIn<'a> {
        _guard: std::sync::MutexGuard<'a, ()>,
        prev: Option<String>,
    }

    impl<'a> AutoOptIn<'a> {
        fn enabled() -> Self {
            let guard = ENV_GUARD.lock().unwrap_or_else(|e| e.into_inner());
            let prev = std::env::var("GRAPHY_AUTO_GITIGNORE").ok();
            // SAFETY: Tests serialised via ENV_GUARD; no other thread mutates env here.
            unsafe { std::env::set_var("GRAPHY_AUTO_GITIGNORE", "1") };
            Self { _guard: guard, prev }
        }
        fn disabled() -> Self {
            let guard = ENV_GUARD.lock().unwrap_or_else(|e| e.into_inner());
            let prev = std::env::var("GRAPHY_AUTO_GITIGNORE").ok();
            unsafe { std::env::remove_var("GRAPHY_AUTO_GITIGNORE") };
            Self { _guard: guard, prev }
        }
    }

    impl Drop for AutoOptIn<'_> {
        fn drop(&mut self) {
            unsafe {
                match self.prev.take() {
                    Some(v) => std::env::set_var("GRAPHY_AUTO_GITIGNORE", v),
                    None => std::env::remove_var("GRAPHY_AUTO_GITIGNORE"),
                }
            }
        }
    }

    #[test]
    fn opt_in_off_by_default_writes_nothing() {
        let _env = AutoOptIn::disabled();
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "node_modules/\n").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        assert_eq!(fs::read_to_string(&gi).unwrap(), "node_modules/\n");
    }

    #[test]
    fn missing_gitignore_is_not_created() {
        let _env = AutoOptIn::enabled();
        let dir = tempdir().unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        assert!(!dir.path().join(".gitignore").exists());
    }

    #[test]
    fn appends_entry_to_existing_gitignore() {
        let _env = AutoOptIn::enabled();
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
        let _env = AutoOptIn::enabled();
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
            let _env = AutoOptIn::enabled();
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
        let _env = AutoOptIn::enabled();
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "# graphy-out/\nother\n").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        let out = fs::read_to_string(&gi).unwrap();
        assert!(out.contains("\ngraphy-out/\n"), "{out:?}");
    }

    #[test]
    fn appends_newline_when_existing_file_has_no_trailing_newline() {
        let _env = AutoOptIn::enabled();
        let dir = tempdir().unwrap();
        let gi = dir.path().join(".gitignore");
        fs::write(&gi, "target/").unwrap();
        ensure_graphy_out_excluded(dir.path()).unwrap();
        assert_eq!(
            fs::read_to_string(&gi).unwrap(),
            "target/\ngraphy-out/\n"
        );
    }
}
