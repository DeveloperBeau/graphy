//! Subprocess-level tests for the `graphy` CLI.

use std::fs;
use std::process::Command;

use tempfile::tempdir;

fn graphy_bin() -> std::path::PathBuf {
    std::path::PathBuf::from(env!("CARGO_BIN_EXE_graphy"))
}

#[test]
fn doctor_prints_version() {
    let out = Command::new(graphy_bin()).arg("doctor").output().unwrap();
    assert!(out.status.success());
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains("graphy"));
    assert!(stdout.contains(env!("CARGO_PKG_VERSION")));
}

#[test]
fn explicit_run_subcommand_writes_outputs() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let out = Command::new(graphy_bin())
        .arg("run")
        .arg(dir.path())
        .arg("--out")
        .arg(dir.path())
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "stderr: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(dir.path().join("graphy-out").join("graph.json").exists());
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains("scanned"));
    assert!(stdout.contains("graph:"));
    assert!(stdout.contains("report:"));
    assert!(stdout.contains("html:"));
}

#[test]
fn default_path_arg_runs_pipeline() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let out = Command::new(graphy_bin())
        .arg(dir.path())
        .arg("--out")
        .arg(dir.path())
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "stderr: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(dir.path().join("graphy-out").join("graph.json").exists());
}

#[test]
fn docs_flag_picks_up_markdown() {
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("notes.md"), "# Notes\n").unwrap();
    let out = Command::new(graphy_bin())
        .arg("run")
        .arg(dir.path())
        .arg("--docs")
        .arg("--out")
        .arg(dir.path())
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "stderr: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stdout = String::from_utf8_lossy(&out.stdout);
    // Should report at least one file scanned even though no extractor handles markdown yet.
    assert!(stdout.contains("scanned 1 files"));
}

#[test]
fn run_subcommand_no_path_fails_cleanly() {
    let out = Command::new(graphy_bin()).arg("run").output().unwrap();
    assert!(!out.status.success());
    let stderr = String::from_utf8_lossy(&out.stderr);
    // clap should complain about the missing positional argument.
    assert!(stderr.to_lowercase().contains("required") || stderr.to_lowercase().contains("error"));
}

#[test]
fn help_runs_and_lists_subcommands() {
    let out = Command::new(graphy_bin()).arg("--help").output().unwrap();
    assert!(out.status.success());
    let stdout = String::from_utf8_lossy(&out.stdout);
    for cmd in ["run", "watch", "serve", "doctor"] {
        assert!(stdout.contains(cmd), "help missing: {cmd}");
    }
}

#[test]
fn version_flag_prints_semver() {
    let out = Command::new(graphy_bin())
        .arg("--version")
        .output()
        .unwrap();
    assert!(out.status.success());
    let stdout = String::from_utf8_lossy(&out.stdout);
    assert!(stdout.contains(env!("CARGO_PKG_VERSION")));
}

#[test]
#[cfg(unix)]
fn watch_subcommand_runs_initial_build_then_blocks() {
    // `graphy watch` blocks indefinitely. Spawn it, wait for the initial
    // build, then send SIGTERM so the binary's atexit handlers can run
    // (SIGKILL would skip coverage flushing). Verifies the initial bundle
    // landed and exercises the CLI's `Command::Watch` dispatch arm.
    let dir = tempdir().unwrap();
    fs::write(dir.path().join("a.rs"), "pub fn f(){}\n").unwrap();
    let child = std::process::Command::new(graphy_bin())
        .arg("watch")
        .arg(dir.path())
        .arg("--out")
        .arg(dir.path())
        .stdout(std::process::Stdio::null())
        .stderr(std::process::Stdio::null())
        .spawn()
        .unwrap();
    let pid = child.id();
    let graph_json = dir.path().join("graphy-out").join("graph.json");
    let deadline = std::time::Instant::now() + std::time::Duration::from_secs(8);
    while std::time::Instant::now() < deadline {
        if graph_json.exists() {
            break;
        }
        std::thread::sleep(std::time::Duration::from_millis(100));
    }
    let _ = std::process::Command::new("kill")
        .arg("-TERM")
        .arg(pid.to_string())
        .status();
    let mut child = child;
    let _ = child.wait();
    assert!(
        graph_json.exists(),
        "initial build did not produce graph.json"
    );
}

#[test]
fn dot_root_and_absolute_root_share_one_cache_manifest() {
    // `tempdir()` on macOS returns a path under a symlinked `/var/folders`;
    // spawning a child with that as `current_dir` and letting it resolve
    // `.` produces the real `/private/var/...` form (see getcwd(3)).
    // Canonicalize up front so both invocations name the same root the
    // same way — otherwise this test would fail on an OS/tempdir artifact
    // rather than the defect under test.
    let dir = tempdir().unwrap();
    let root = dir.path().canonicalize().unwrap();
    fs::write(root.join("a.rs"), "pub fn f(){}\n").unwrap();
    fs::write(root.join("b.rs"), "pub fn g(){}\n").unwrap();

    let dot_run = Command::new(graphy_bin())
        .arg("run")
        .arg(".")
        .arg("--out")
        .arg(&root)
        .current_dir(&root)
        .output()
        .unwrap();
    assert!(
        dot_run.status.success(),
        "stderr: {}",
        String::from_utf8_lossy(&dot_run.stderr)
    );

    let abs_run = Command::new(graphy_bin())
        .arg("run")
        .arg(&root)
        .arg("--out")
        .arg(&root)
        .output()
        .unwrap();
    assert!(
        abs_run.status.success(),
        "stderr: {}",
        String::from_utf8_lossy(&abs_run.stderr)
    );

    let manifest_path = root.join("graphy-out").join(".cache").join("manifest.json");
    let manifest: serde_json::Value =
        serde_json::from_str(&fs::read_to_string(&manifest_path).unwrap()).unwrap();
    let entries = manifest["entries"].as_object().unwrap();
    assert_eq!(
        entries.len(),
        2,
        "expected one cache entry per file, got {entries:?}"
    );
}

#[test]
fn serve_tolerates_missing_graph_and_returns_empty_stats() {
    // First-session UX: the MCP server is started before any graph has been
    // built. `graphy serve` must not exit — it should hang on stdin and
    // return zero-valued stats so the hook-driven build has time to land.
    use std::io::Write;
    use std::process::{Command, Stdio};
    let dir = tempdir().unwrap();
    let mut child = Command::new(graphy_bin())
        .arg("serve")
        .current_dir(dir.path())
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    {
        let stdin = child.stdin.as_mut().unwrap();
        writeln!(
            stdin,
            r#"{{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{{"name":"stats","arguments":{{}}}}}}"#
        )
        .unwrap();
    }
    let out = child.wait_with_output().unwrap();
    assert!(
        out.status.success(),
        "serve should exit cleanly on stdin EOF, stderr: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    let stdout = String::from_utf8_lossy(&out.stdout);
    let response: serde_json::Value = stdout
        .lines()
        .find(|l| !l.is_empty())
        .and_then(|l| serde_json::from_str(l).ok())
        .unwrap_or_else(|| panic!("no JSON-RPC response on stdout: {stdout:?}"));
    let text = response["result"]["content"][0]["text"]
        .as_str()
        .unwrap_or_else(|| panic!("no content text in response: {response}"));
    let payload: serde_json::Value = serde_json::from_str(text).unwrap();
    assert_eq!(payload["nodes"], 0);
    assert_eq!(payload["edges"], 0);
    assert_eq!(payload["communities"], 0);
}
