//! Input validation. label sanitization + symlink-aware path checks.

use std::path::{Component, Path, PathBuf};

use anyhow::{Result, anyhow};

const MAX_LABEL_LEN: usize = 256;

/// Strip control chars (except `\t`), HTML-escape, cap length at 256.
pub fn sanitize_label(label: &str) -> String {
    let cleaned: String = label
        .chars()
        .filter(|c| !c.is_control() || *c == '\t')
        .collect();
    let escaped = html_escape(&cleaned);
    truncate_chars(&escaped, MAX_LABEL_LEN)
}

/// Verify `graph_path` resolves inside `root`. Refuses `..` traversal even
/// when the target does not exist on disk; resolves symlinks against the
/// real filesystem so that link-based escapes are caught.
pub fn validate_graph_path(root: &Path, graph_path: &Path) -> Result<PathBuf> {
    let abs_root = canonicalize_partial(root)?;
    let abs_target = canonicalize_partial(&join_abs(graph_path)?)?;
    if !abs_target.starts_with(&abs_root) {
        return Err(anyhow!(
            "graph path escapes root: {}",
            abs_target.display()
        ));
    }
    Ok(abs_target)
}

fn html_escape(s: &str) -> String {
    let mut out = String::with_capacity(s.len());
    for c in s.chars() {
        match c {
            '&' => out.push_str("&amp;"),
            '<' => out.push_str("&lt;"),
            '>' => out.push_str("&gt;"),
            '"' => out.push_str("&quot;"),
            '\'' => out.push_str("&#39;"),
            _ => out.push(c),
        }
    }
    out
}

fn truncate_chars(s: &str, n: usize) -> String {
    if s.chars().count() <= n {
        return s.to_string();
    }
    s.chars().take(n).collect()
}

/// Absolutize `p` against cwd if relative, then collapse `..`.
///
/// `Path::components` normalizes mid-path `.` away automatically, so the
/// CurDir match arm is only reachable for a single leading `.` component
/// — which `join_abs` never sees because it pre-joins against an absolute
/// cwd. We therefore fold CurDir into the no-op default and keep an
/// exhaustive match without an unreachable arm.
fn join_abs(p: &Path) -> Result<PathBuf> {
    let abs = if p.is_absolute() {
        p.to_path_buf()
    } else {
        std::env::current_dir()?.join(p)
    };
    let mut out = PathBuf::new();
    for comp in abs.components() {
        // `Path::components` normalizes mid-path `.` away, so `CurDir` is only
        // produced for a single leading `.` — which `join_abs` never sees
        // because it pre-joins relative paths against the absolute cwd. Folding
        // it into the catch-all keeps the match exhaustive without a dead arm.
        match comp {
            Component::ParentDir => {
                if !out.pop() {
                    return Err(anyhow!("path escapes root: {}", p.display()));
                }
            }
            _ => out.push(comp.as_os_str()),
        }
    }
    Ok(out)
}

/// Canonicalize the longest existing prefix of `p`, then append the rest.
/// Lets us check paths that don't exist yet (we're about to write them)
/// while still resolving any symlinks present in the existing portion.
///
/// `abs.ancestors()` ends with the filesystem root, which always exists
/// on Unix and as a drive letter on Windows — so `find(|a| a.exists())`
/// always returns `Some`. The fallback arm is therefore unreachable; we
/// represent it with `unwrap_or_else(|| abs.clone())` so coverage tooling
/// sees a single expression rather than a separate dead error path.
fn canonicalize_partial(p: &Path) -> Result<PathBuf> {
    let abs = join_abs(p)?;
    if let Ok(c) = abs.canonicalize() {
        return Ok(c);
    }
    let mut suffix = PathBuf::new();
    let existing = abs
        .ancestors()
        .inspect(|a| {
            if !a.exists() {
                if let Some(name) = a.file_name() {
                    suffix = Path::new(name).join(&suffix);
                }
            }
        })
        .find(|a| a.exists())
        .unwrap_or(&abs);
    Ok(existing.canonicalize()?.join(&suffix))
}
