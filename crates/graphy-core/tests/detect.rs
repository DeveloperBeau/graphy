//! `detect` module: file collection across extensions, gitignore, symlinks, hidden.

use std::fs;

use graphy_core::detect::{DetectOptions, collect_files};
use tempfile::tempdir;

fn names(paths: &[std::path::PathBuf]) -> Vec<String> {
    paths
        .iter()
        .map(|p| p.file_name().unwrap().to_string_lossy().into_owned())
        .collect()
}

// ---------- success ----------

#[test]
fn collects_files_across_supported_languages() {
    let dir = tempdir().unwrap();
    for f in ["a.rs", "b.py", "c.go", "d.ts", "e.tsx", "f.js"] {
        fs::write(dir.path().join(f), "// x").unwrap();
    }
    let files = collect_files(dir.path(), DetectOptions::default());
    let n = names(&files);
    for f in ["a.rs", "b.py", "c.go", "d.ts", "e.tsx", "f.js"] {
        assert!(n.contains(&f.to_string()), "missing {f}");
    }
}

#[test]
fn skips_unsupported_extensions_by_default() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("readme.md"), "# hi").unwrap();
    fs::write(dir.path().join("notes.txt"), "x").unwrap();
    fs::write(dir.path().join("ok.rs"), "fn main(){}").unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    let n = names(&files);
    assert!(n.contains(&"ok.rs".into()));
    assert!(!n.contains(&"readme.md".into()));
    assert!(!n.contains(&"notes.txt".into()));
}

#[test]
fn include_docs_pulls_in_md_yml_rst() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.md"), "x").unwrap();
    fs::write(dir.path().join("b.yml"), "x: 1").unwrap();
    fs::write(dir.path().join("c.rst"), ".. x").unwrap();
    let files = collect_files(
        dir.path(),
        DetectOptions {
            include_docs: true,
            ..Default::default()
        },
    );
    let n = names(&files);
    assert!(n.contains(&"a.md".into()));
    assert!(n.contains(&"b.yml".into()));
    assert!(n.contains(&"c.rst".into()));
}

#[test]
fn result_is_sorted_for_determinism() {
    let dir = tempdir().unwrap();
    for f in ["z.rs", "a.rs", "m.rs"] {
        fs::write(dir.path().join(f), "").unwrap();
    }
    let files = collect_files(dir.path(), DetectOptions::default());
    let n = names(&files);
    assert_eq!(n, vec!["a.rs", "m.rs", "z.rs"]);
}

// ---------- edge ----------

#[test]
fn empty_directory_returns_empty() {
    let dir = tempdir().unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    assert!(files.is_empty());
}

#[test]
fn nonexistent_root_returns_empty_without_panicking() {
    let bogus = std::path::PathBuf::from("/this/path/does/not/exist/anywhere");
    let files = collect_files(&bogus, DetectOptions::default());
    assert!(files.is_empty());
}

#[test]
fn uppercase_extensions_are_matched_case_insensitively() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("A.RS"), "fn main(){}").unwrap();
    fs::write(dir.path().join("B.PY"), "x=1").unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    assert_eq!(files.len(), 2);
}

#[test]
fn hidden_files_skipped_by_default() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join(".hidden.rs"), "fn x(){}").unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    assert!(files.is_empty());
}

// ---------- gitignore ----------

#[test]
fn honors_gitignore_outside_a_git_repo() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join(".gitignore"), "ignored/\n*.py\n").unwrap();
    fs::create_dir_all(dir.path().join("ignored")).unwrap();
    fs::write(dir.path().join("ignored/a.rs"), "").unwrap();
    fs::write(dir.path().join("skipme.py"), "").unwrap();
    fs::write(dir.path().join("keep.rs"), "").unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    let n = names(&files);
    assert!(n.contains(&"keep.rs".into()));
    assert!(!n.iter().any(|x| x == "a.rs"));
    assert!(!n.contains(&"skipme.py".into()));
}

// ---------- hostile ----------

#[test]
fn refuses_to_follow_symlinks_by_default() {
    #[cfg(unix)]
    {
        let dir = tempdir().unwrap();
        let outside = tempdir().unwrap();
        fs::write(outside.path().join("evil.rs"), "fn x(){}").unwrap();
        let link = dir.path().join("escape");
        std::os::unix::fs::symlink(outside.path(), &link).unwrap();
        let files = collect_files(dir.path(), DetectOptions::default());
        assert!(
            !files.iter().any(|p| p.ends_with("evil.rs")),
            "symlink escape should not be followed"
        );
    }
}

#[test]
fn follow_symlinks_opt_in_is_honored() {
    #[cfg(unix)]
    {
        let dir = tempdir().unwrap();
        let outside = tempdir().unwrap();
        fs::write(outside.path().join("real.rs"), "fn x(){}").unwrap();
        std::os::unix::fs::symlink(outside.path(), dir.path().join("linked")).unwrap();
        let files = collect_files(
            dir.path(),
            DetectOptions {
                follow_symlinks: true,
                ..Default::default()
            },
        );
        assert!(files.iter().any(|p| p.ends_with("real.rs")));
    }
}

#[test]
fn massive_tree_completes_in_reasonable_time() {
    let dir = tempdir().unwrap();
    for i in 0..500 {
        let sub = dir
            .path()
            .join(format!("d{}/d{}/d{}", i % 7, i % 11, i % 13));
        fs::create_dir_all(&sub).unwrap();
        fs::write(sub.join(format!("f{i}.rs")), "").unwrap();
    }
    let files = collect_files(dir.path(), DetectOptions::default());
    assert_eq!(files.len(), 500);
}

#[test]
fn rejects_binary_with_supported_suffix_by_simply_collecting_it() {
    // detect is a path-level filter; content inspection happens in extract.
    // We document that here: a binary file with `.rs` is still collected,
    // and downstream extractor must handle it safely (covered in extract_*).
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("malformed.rs"), [0xFFu8; 1024]).unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    assert_eq!(files.len(), 1);
}
