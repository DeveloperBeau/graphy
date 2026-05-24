//! Walk a directory and collect files of interest.
//!
//! Respects `.gitignore` via
//! the `ignore` crate.

use std::path::{Path, PathBuf};

use ignore::WalkBuilder;
use once_cell::sync::Lazy;
use std::collections::HashSet;

macro_rules! ext_set {
    ($($s:literal),* $(,)?) => {{
        let mut set = HashSet::new();
        $(set.insert($s);)*
        set
    }};
}

pub static CODE_EXTENSIONS: Lazy<HashSet<&'static str>> = Lazy::new(|| {
    ext_set!(
        "py", "ts", "tsx", "js", "jsx", "mjs", "ejs", "ets", "go", "rs",
        "java", "groovy", "gradle", "cpp", "cc", "cxx", "c", "h", "hpp",
        "rb", "swift", "kt", "kts", "cs", "scala", "php", "lua", "luau",
        "toc", "zig", "ps1", "ex", "exs", "m", "mm", "jl", "vue", "svelte",
        "astro", "dart", "v", "sv", "sql", "r", "f", "f90", "f95", "f03",
        "f08", "pas", "pp", "dpr", "dpk", "lpr", "inc", "dfm", "lfm", "lpk",
        "sh", "bash", "json",
    )
});

pub static DOC_EXTENSIONS: Lazy<HashSet<&'static str>> = Lazy::new(|| {
    ext_set!("md", "mdx", "qmd", "txt", "rst", "yaml", "yml")
});

#[derive(Debug, Clone, Copy, Default)]
pub struct DetectOptions {
    pub include_docs: bool,
    pub follow_symlinks: bool,
}

/// Recursively collect candidate files under `root`.
pub fn collect_files(root: &Path, opts: DetectOptions) -> Vec<PathBuf> {
    let mut files = Vec::new();
    let mut builder = WalkBuilder::new(root);
    builder
        .follow_links(opts.follow_symlinks)
        .require_git(false)
        .git_ignore(true)
        .git_global(true)
        .git_exclude(true)
        .ignore(true)
        .parents(true)
        .hidden(true);
    // The output directory is treated as opaque — re-ingesting it would
    // cause graph.json to be parsed as input on every subsequent run.
    let mut overrides = ignore::overrides::OverrideBuilder::new(root);
    let _ = overrides.add("!graphy-out/");
    let _ = overrides.add("!**/graphy-out/");
    if let Ok(o) = overrides.build() {
        builder.overrides(o);
    }
    let walker = builder.build();

    for dent in walker.flatten() {
        if !dent.file_type().is_some_and(|t| t.is_file()) {
            continue;
        }
        let path = dent.path();
        let ext = path
            .extension()
            .and_then(|s| s.to_str())
            .map(|s| s.to_ascii_lowercase());
        let Some(ext) = ext else { continue };
        let is_code = CODE_EXTENSIONS.contains(ext.as_str());
        let is_doc = opts.include_docs && DOC_EXTENSIONS.contains(ext.as_str());
        if is_code || is_doc {
            files.push(path.to_path_buf());
        }
    }
    files.sort();
    files
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::fs;
    use tempfile::tempdir;

    #[test]
    fn collects_code_files_skips_unknown() {
        let dir = tempdir().unwrap();
        fs::write(dir.path().join("a.rs"), "fn main() {}").unwrap();
        fs::write(dir.path().join("b.py"), "x=1").unwrap();
        fs::write(dir.path().join("c.txt"), "no").unwrap();
        let files = collect_files(dir.path(), DetectOptions::default());
        let names: Vec<_> = files
            .iter()
            .map(|p| p.file_name().unwrap().to_string_lossy().into_owned())
            .collect();
        assert!(names.contains(&"a.rs".to_string()));
        assert!(names.contains(&"b.py".to_string()));
        assert!(!names.contains(&"c.txt".to_string()));
    }

    #[test]
    fn includes_docs_when_opted_in() {
        let dir = tempdir().unwrap();
        fs::write(dir.path().join("readme.md"), "# hi").unwrap();
        let files = collect_files(
            dir.path(),
            DetectOptions { include_docs: true, ..Default::default() },
        );
        assert_eq!(files.len(), 1);
    }
}
