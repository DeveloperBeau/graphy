//! `serve` module: JSON-RPC over stdio for graph queries.

use std::fs;

use graphy_core::serve::{Index, handle_line};
use serde_json::{Value, json};
use tempfile::tempdir;

fn sample_graph() -> Value {
    json!({
        "nodes": [
            { "id": "a", "label": "Alpha", "source_file": "a.rs", "source_location": "L1",
              "kind": "function", "community": 0 },
            { "id": "b", "label": "Beta",  "source_file": "b.rs", "source_location": "L1",
              "kind": "function", "community": 0 },
            { "id": "c", "label": "Charlie", "source_file": "c.rs", "source_location": "L1",
              "kind": "class", "community": 1 },
            { "id": "d", "label": "Delta", "source_file": "d.rs", "source_location": "L1",
              "kind": "function", "community": 1 }
        ],
        "edges": [
            { "source": "a", "target": "b", "relation": "calls",   "confidence": "INFERRED" },
            { "source": "b", "target": "c", "relation": "imports", "confidence": "EXTRACTED" },
            { "source": "c", "target": "d", "relation": "calls",   "confidence": "INFERRED" }
        ]
    })
}

fn make_index() -> Index {
    let g: graphy_core::serve::StoredGraph =
        serde_json::from_value(sample_graph()).unwrap();
    Index::from_graph(g)
}

fn call(idx: &Index, req: Value) -> Value {
    let line = serde_json::to_string(&req).unwrap();
    let resp = handle_line(idx, &line);
    serde_json::to_value(&resp).unwrap()
}

// ---------- success ----------

#[test]
fn initialize_returns_server_descriptor() {
    let idx = make_index();
    let v = call(&idx, json!({ "jsonrpc": "2.0", "id": 1, "method": "initialize" }));
    let result = &v["result"];
    assert_eq!(result["name"], "graphy");
    assert!(result["version"].is_string());
}

#[test]
fn tools_list_includes_expected_tools() {
    let idx = make_index();
    let v = call(&idx, json!({ "jsonrpc": "2.0", "id": 2, "method": "tools/list" }));
    let names: Vec<_> = v["result"]["tools"]
        .as_array().unwrap().iter()
        .filter_map(|t| t["name"].as_str()).collect();
    for expected in ["stats", "search_label", "neighbors", "query_node", "shortest_path"] {
        assert!(names.contains(&expected), "missing tool: {expected}");
    }
}

#[test]
fn stats_tool_returns_counts() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 3, "method": "tools/call",
        "params": { "name": "stats", "arguments": {} }
    }));
    assert_eq!(v["result"]["nodes"], 4);
    assert_eq!(v["result"]["edges"], 3);
    assert_eq!(v["result"]["communities"], 2);
}

#[test]
fn search_label_finds_substring_match() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 4, "method": "tools/call",
        "params": { "name": "search_label", "arguments": { "q": "alp" } }
    }));
    let matches = v["result"]["matches"].as_array().unwrap();
    assert_eq!(matches.len(), 1);
    assert_eq!(matches[0]["label"], "Alpha");
}

#[test]
fn search_label_respects_limit() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 5, "method": "tools/call",
        "params": { "name": "search_label", "arguments": { "q": "", "limit": 2 } }
    }));
    assert_eq!(v["result"]["matches"].as_array().unwrap().len(), 2);
}

#[test]
fn neighbors_returns_both_directions() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 6, "method": "tools/call",
        "params": { "name": "neighbors", "arguments": { "id": "b" } }
    }));
    let out = v["result"]["outgoing"].as_array().unwrap();
    let inc = v["result"]["incoming"].as_array().unwrap();
    assert!(out.iter().any(|e| e["target"] == "c"));
    assert!(inc.iter().any(|e| e["source"] == "a"));
}

#[test]
fn query_node_returns_full_metadata() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 7, "method": "tools/call",
        "params": { "name": "query_node", "arguments": { "id": "a" } }
    }));
    assert_eq!(v["result"]["label"], "Alpha");
    assert_eq!(v["result"]["source_file"], "a.rs");
    assert_eq!(v["result"]["kind"], "function");
}

#[test]
fn shortest_path_walks_through_intermediate_nodes() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 8, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "a", "to": "d" } }
    }));
    let path: Vec<String> = v["result"]["path"]
        .as_array().unwrap().iter()
        .filter_map(|p| p.as_str().map(String::from)).collect();
    assert_eq!(path, vec!["a", "b", "c", "d"]);
}

#[test]
fn shortest_path_returns_singleton_for_identical_endpoints() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 9, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "a", "to": "a" } }
    }));
    let path = v["result"]["path"].as_array().unwrap();
    assert_eq!(path.len(), 1);
}

// ---------- failure ----------

#[test]
fn parse_error_reports_minus_32700() {
    let idx = make_index();
    let resp = handle_line(&idx, "{not valid json");
    let v = serde_json::to_value(&resp).unwrap();
    assert_eq!(v["error"]["code"], -32700);
}

#[test]
fn unknown_method_returns_error() {
    let idx = make_index();
    let v = call(&idx, json!({ "jsonrpc": "2.0", "id": 10, "method": "frobnicate" }));
    assert!(v["error"]["message"].as_str().unwrap().contains("frobnicate"));
}

#[test]
fn tools_call_missing_name_errors() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 11, "method": "tools/call", "params": { "arguments": {} }
    }));
    assert!(v["error"]["message"].as_str().unwrap().contains("tool name"));
}

#[test]
fn tools_call_unknown_tool_errors() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 12, "method": "tools/call",
        "params": { "name": "nonexistent", "arguments": {} }
    }));
    assert!(v["error"]["message"].as_str().unwrap().contains("nonexistent"));
}

#[test]
fn neighbors_unknown_node_errors() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 13, "method": "tools/call",
        "params": { "name": "neighbors", "arguments": { "id": "ghost" } }
    }));
    assert!(v["error"]["message"].as_str().unwrap().contains("ghost"));
}

#[test]
fn query_node_missing_id_errors() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 14, "method": "tools/call",
        "params": { "name": "query_node", "arguments": {} }
    }));
    assert!(v["error"]["message"].as_str().unwrap().contains("missing id"));
}

#[test]
fn shortest_path_between_disconnected_nodes_returns_empty() {
    // Build an index where two nodes have no edges between them at all.
    let g = json!({
        "nodes": [
            { "id": "x", "label": "X", "source_file": null, "source_location": null,
              "kind": null, "community": null },
            { "id": "y", "label": "Y", "source_file": null, "source_location": null,
              "kind": null, "community": null }
        ],
        "edges": []
    });
    let stored: graphy_core::serve::StoredGraph = serde_json::from_value(g).unwrap();
    let idx = Index::from_graph(stored);
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 15, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "x", "to": "y" } }
    }));
    assert!(v["result"]["path"].as_array().unwrap().is_empty());
}

#[test]
fn shortest_path_walks_via_incoming_edges_when_needed() {
    // Build a graph where reaching `c` from `a` is only possible by following
    // an edge backwards: a→b, c→b. BFS must traverse via in_edges from b.
    let g = json!({
        "nodes": [
            { "id": "a", "label": "A" }, { "id": "b", "label": "B" }, { "id": "c", "label": "C" }
        ],
        "edges": [
            { "source": "a", "target": "b", "relation": "calls", "confidence": "INFERRED" },
            { "source": "c", "target": "b", "relation": "calls", "confidence": "INFERRED" }
        ]
    });
    let stored: graphy_core::serve::StoredGraph = serde_json::from_value(g).unwrap();
    let idx = Index::from_graph(stored);
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 17, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "a", "to": "c" } }
    }));
    let path: Vec<String> = v["result"]["path"]
        .as_array().unwrap().iter()
        .filter_map(|p| p.as_str().map(String::from)).collect();
    assert_eq!(path, vec!["a", "b", "c"]);
}

#[test]
fn shortest_path_via_incoming_finds_direct_predecessor() {
    // a→b means from b, the only neighbor is a (via in_edges). Reaching a from b
    // exercises the in-edges branch's "found target" early return.
    let g = json!({
        "nodes": [{ "id": "a", "label": "A" }, { "id": "b", "label": "B" }],
        "edges": [
            { "source": "a", "target": "b", "relation": "calls", "confidence": "INFERRED" }
        ]
    });
    let stored: graphy_core::serve::StoredGraph = serde_json::from_value(g).unwrap();
    let idx = Index::from_graph(stored);
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 18, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "b", "to": "a" } }
    }));
    let path: Vec<String> = v["result"]["path"]
        .as_array().unwrap().iter()
        .filter_map(|p| p.as_str().map(String::from)).collect();
    assert_eq!(path, vec!["b", "a"]);
}

#[test]
fn shortest_path_unknown_endpoint_returns_empty() {
    let idx = make_index();
    let v = call(&idx, json!({
        "jsonrpc": "2.0", "id": 16, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "ghost", "to": "a" } }
    }));
    assert!(v["result"]["path"].as_array().unwrap().is_empty());
}

// ---------- loader ----------

#[test]
fn index_loads_from_disk() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("graph.json");
    fs::write(&p, serde_json::to_string(&sample_graph()).unwrap()).unwrap();
    let idx = Index::load(&p).unwrap();
    assert_eq!(idx.nodes.len(), 4);
}

#[test]
fn index_load_surfaces_io_error_for_missing_file() {
    let err = Index::load(std::path::Path::new("/no/such/graph.json")).unwrap_err();
    assert!(err.to_string().contains("read"));
}

#[test]
fn index_load_surfaces_parse_error_for_malformed_json() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("bad.json");
    fs::write(&p, "{ not valid").unwrap();
    let err = Index::load(&p).unwrap_err();
    assert!(err.to_string().contains("parse"));
}
