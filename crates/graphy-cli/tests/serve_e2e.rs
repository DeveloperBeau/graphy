//! End-to-end smoke test for `graphy serve`: spawn the CLI as a subprocess,
//! write JSON-RPC requests to stdin, read responses from stdout.

use std::fs;
use std::io::{BufRead, BufReader, Write};
use std::process::{Command, Stdio};

use serde_json::{Value, json};
use tempfile::tempdir;

fn graphy_bin() -> std::path::PathBuf {
    // CARGO_BIN_EXE_<name> is set by Cargo for integration tests of bin crates.
    std::path::PathBuf::from(env!("CARGO_BIN_EXE_graphy"))
}

#[test]
fn serve_loop_handles_blank_lines_and_eof() {
    use serde_json::Value;
    // Drive the stdio loop through a subprocess: include a blank line that the
    // loop must skip, then close stdin so read_line returns 0 and the loop
    // exits cleanly. Exercises lines around `if trimmed.is_empty() continue`.
    let dir = tempdir().unwrap();
    let p = dir.path().join("graph.json");
    fs::write(
        &p,
        serde_json::to_string(&json!({
            "nodes": [{ "id": "a", "label": "A" }], "edges": []
        }))
        .unwrap(),
    )
    .unwrap();
    let mut child = Command::new(graphy_bin())
        .arg("serve")
        .arg("--graph")
        .arg(&p)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::null())
        .spawn()
        .unwrap();
    let mut stdin = child.stdin.take().unwrap();
    let mut reader = BufReader::new(child.stdout.take().unwrap());
    writeln!(stdin).unwrap();
    writeln!(
        stdin,
        "{}",
        serde_json::to_string(&json!({ "jsonrpc": "2.0", "id": 99, "method": "initialize" }))
            .unwrap()
    )
    .unwrap();
    drop(stdin);
    let mut line = String::new();
    reader.read_line(&mut line).unwrap();
    let v: Value = serde_json::from_str(line.trim()).unwrap();
    assert_eq!(v["id"], 99);
    let _ = child.wait();
}

#[test]
fn serve_responds_to_initialize_and_tools_call() {
    let dir = tempdir().unwrap();
    let graph_path = dir.path().join("graph.json");
    let graph = json!({
        "nodes": [
            { "id": "a", "label": "Alpha", "community": 0 },
            { "id": "b", "label": "Beta", "community": 0 }
        ],
        "edges": [
            { "source": "a", "target": "b", "relation": "calls", "confidence": "INFERRED" }
        ]
    });
    fs::write(&graph_path, serde_json::to_string(&graph).unwrap()).unwrap();

    let mut child = Command::new(graphy_bin())
        .arg("serve")
        .arg("--graph")
        .arg(&graph_path)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::null())
        .spawn()
        .expect("spawn graphy");

    let mut stdin = child.stdin.take().unwrap();
    let stdout = child.stdout.take().unwrap();
    let mut reader = BufReader::new(stdout);

    let req1 = json!({ "jsonrpc": "2.0", "id": 1, "method": "initialize" });
    writeln!(stdin, "{}", serde_json::to_string(&req1).unwrap()).unwrap();

    let req2 = json!({
        "jsonrpc": "2.0", "id": 2, "method": "tools/call",
        "params": { "name": "stats", "arguments": {} }
    });
    writeln!(stdin, "{}", serde_json::to_string(&req2).unwrap()).unwrap();
    drop(stdin); // close stdin so the loop exits when responses are drained

    let mut line = String::new();
    reader.read_line(&mut line).unwrap();
    let v1: Value = serde_json::from_str(line.trim()).unwrap();
    assert_eq!(v1["id"], 1);
    assert_eq!(v1["result"]["name"], "graphy");

    line.clear();
    reader.read_line(&mut line).unwrap();
    let v2: Value = serde_json::from_str(line.trim()).unwrap();
    assert_eq!(v2["id"], 2);
    assert_eq!(v2["result"]["nodes"], 2);
    assert_eq!(v2["result"]["edges"], 1);

    let _ = child.wait();
}
