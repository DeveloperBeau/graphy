//! `security` module: label sanitization + graph-path validation.
//!
//! Hostile-input cases sit alongside success/edge paths since the whole point
//! of this module is to reject those.

use std::fs;

use graphy_core::security::{sanitize_label, validate_graph_path};
use tempfile::tempdir;

// ---------- sanitize_label: success / edge ----------

#[test]
fn sanitize_passthroughs_safe_label() {
    assert_eq!(sanitize_label("UserService"), "UserService");
}

#[test]
fn sanitize_preserves_tab() {
    let s = sanitize_label("col1\tcol2");
    assert!(s.contains('\t'));
}

#[test]
fn sanitize_html_escapes_angles_and_amps() {
    let s = sanitize_label("<script>alert(&x)</script>");
    assert!(!s.contains('<'));
    assert!(!s.contains('>'));
    assert!(s.contains("&lt;script&gt;"));
    assert!(s.contains("&amp;"));
}

#[test]
fn sanitize_html_escapes_quotes() {
    let s = sanitize_label("\"single' and double\"");
    assert!(s.contains("&quot;"));
    assert!(s.contains("&#39;"));
}

#[test]
fn sanitize_empty_string_is_empty() {
    assert_eq!(sanitize_label(""), "");
}

// ---------- sanitize_label: hostile ----------

#[test]
fn sanitize_strips_control_chars() {
    let s = sanitize_label("ok\x07\x1b[31mred\x1b[0m");
    assert!(!s.contains('\x1b'), "ANSI escape must be stripped: {s:?}");
    assert!(!s.contains('\x07'));
    assert!(s.contains("red"));
}

#[test]
fn sanitize_strips_null_byte() {
    let s = sanitize_label("admin\0root");
    assert!(!s.contains('\0'));
    assert!(s.contains("admin"));
    assert!(s.contains("root"));
}

#[test]
fn sanitize_strips_newline_and_cr() {
    let s = sanitize_label("line1\nline2\r\nline3");
    assert!(!s.contains('\n'));
    assert!(!s.contains('\r'));
}

#[test]
fn sanitize_strips_rtl_override_format_char_if_control() {
    // U+202E is a Bidi override (Cf category). Some renderers treat it as
    // control; `char::is_control` returns false for it, so we just confirm
    // the function doesn't crash on it. Documented behaviour.
    let s = sanitize_label("safe\u{202E}name");
    assert!(s.contains("safe"));
}

#[test]
fn sanitize_caps_at_256_chars() {
    let big = "a".repeat(10_000);
    let s = sanitize_label(&big);
    assert_eq!(s.chars().count(), 256);
}

#[test]
fn sanitize_caps_unicode_by_chars_not_bytes() {
    // 1 character but 3 bytes — must count as 1.
    let glyph = "日";
    let many = glyph.repeat(500);
    let s = sanitize_label(&many);
    assert_eq!(s.chars().count(), 256);
}

// ---------- validate_graph_path: success ----------

#[test]
fn validate_accepts_path_inside_root() {
    let dir = tempdir().unwrap();
    let target = dir.path().join("graph.json");
    fs::write(&target, "{}").unwrap();
    let ok = validate_graph_path(dir.path(), &target).unwrap();
    assert!(ok.starts_with(dir.path().canonicalize().unwrap()));
}

#[test]
fn validate_accepts_yet_to_be_written_file_under_root() {
    let dir = tempdir().unwrap();
    let target = dir.path().join("not-yet/graph.json");
    let ok = validate_graph_path(dir.path(), &target).unwrap();
    assert!(ok.starts_with(dir.path().canonicalize().unwrap()));
}

// ---------- validate_graph_path: hostile ----------

#[test]
fn validate_rejects_lexical_dotdot_escape() {
    let dir = tempdir().unwrap();
    let nested = dir.path().join("a/b/c");
    fs::create_dir_all(&nested).unwrap();
    // Four ".." segments from a/b/c pop us past dir — an actual escape.
    let escape = nested.join("../../../../escape.json");
    let err = validate_graph_path(dir.path(), &escape).unwrap_err();
    assert!(err.to_string().contains("escapes root"));
}

#[test]
fn validate_accepts_dotdot_that_lands_back_inside_root() {
    let dir = tempdir().unwrap();
    let nested = dir.path().join("a/b/c");
    fs::create_dir_all(&nested).unwrap();
    // Three "..", land back at `dir/escape.json` — that's still inside root.
    let inside = nested.join("../../../escape.json");
    validate_graph_path(dir.path(), &inside).unwrap();
}

#[test]
fn validate_rejects_absolute_path_outside_root() {
    let dir = tempdir().unwrap();
    let outside = std::path::PathBuf::from("/etc/passwd");
    let err = validate_graph_path(dir.path(), &outside).unwrap_err();
    assert!(err.to_string().contains("escapes root"));
}

#[test]
fn validate_rejects_symlink_pointing_outside_root() {
    let dir = tempdir().unwrap();
    let outside_target = tempdir().unwrap();
    let outside_file = outside_target.path().join("secret.json");
    fs::write(&outside_file, "x").unwrap();

    let link = dir.path().join("graph.json");
    #[cfg(unix)]
    std::os::unix::fs::symlink(&outside_file, &link).unwrap();
    #[cfg(not(unix))]
    fs::copy(&outside_file, &link).unwrap();

    // canonicalize resolves the symlink to outside_target → must reject.
    #[cfg(unix)]
    {
        let err = validate_graph_path(dir.path(), &link).unwrap_err();
        assert!(err.to_string().contains("escapes root"));
    }
}

#[test]
fn validate_rejects_excessive_dotdot_under_root() {
    let dir = tempdir().unwrap();
    let attack = dir.path().join("a/../../../../../../etc/passwd");
    let err = validate_graph_path(dir.path(), &attack).unwrap_err();
    assert!(err.to_string().contains("escapes root"));
}
