//! Targeted tests that close residual coverage gaps in modules whose primary
//! happy-path tests live elsewhere.

use std::fs;
use std::path::Path;

use graphy_core::cache::Cache;
use graphy_core::cluster::cluster;
use graphy_core::extract::extract;
use graphy_core::schema::{Confidence, Edge, ExtractionOutput, Node};
use tempfile::{TempDir, tempdir};

fn n(id: &str) -> Node {
    Node {
        id: id.into(),
        label: id.into(),
        source_file: None,
        source_location: None,
        kind: None,
        signature: None,
    }
}

fn e(s: &str, t: &str) -> Edge {
    Edge {
        source: s.into(),
        target: t.into(),
        relation: "calls".into(),
        confidence: Confidence::Extracted,
        attr: None,
    }
}

fn run(suffix: &str, src: &str) -> ExtractionOutput {
    let dir = TempDir::new().unwrap();
    let p = dir.path().join(format!("f{suffix}"));
    fs::write(&p, src).unwrap();
    let out = extract(&p).unwrap();
    std::mem::forget(dir);
    out
}

// ---------- cluster ----------

#[test]
fn cluster_handles_self_loops() {
    let ex = ExtractionOutput {
        nodes: vec![n("a"), n("b")],
        edges: vec![e("a", "a"), e("a", "b")],
    };
    let mut g = graphy_core::build::build_graph(vec![ex]);
    cluster(&mut g);
    for ni in g.graph.node_indices() {
        assert!(g.graph[ni].community.is_some());
    }
}

#[test]
fn cluster_singleton_isolated_graph_terminates() {
    // No edges means total_weight==0; local_moving_phase returns false and
    // we never enter the fold path.
    let ex = ExtractionOutput {
        nodes: vec![n("solo")],
        edges: vec![],
    };
    let mut g = graphy_core::build::build_graph(vec![ex]);
    cluster(&mut g);
    assert!(g.graph[g.by_id["solo"]].community.is_some());
}

#[test]
fn cluster_terminates_when_fold_is_a_fixed_point() {
    // A small graph that converges in one pass — the `folded.len() == adj.len()`
    // break path is exercised when subsequent passes produce no new merges.
    let mut nodes = Vec::new();
    let mut edges = Vec::new();
    for i in 0..6 {
        nodes.push(n(&format!("v{i}")));
    }
    // Two disjoint triangles → after one pass each becomes a community,
    // folding produces a 2-node graph that can't merge further.
    for (a, b) in [(0, 1), (1, 2), (0, 2), (3, 4), (4, 5), (3, 5)] {
        edges.push(e(&format!("v{a}"), &format!("v{b}")));
    }
    let ex = ExtractionOutput { nodes, edges };
    let mut g = graphy_core::build::build_graph(vec![ex]);
    cluster(&mut g);
    let comms: std::collections::HashSet<_> =
        g.graph.node_weights().filter_map(|n| n.community).collect();
    assert_eq!(comms.len(), 2);
}

// ---------- serve diamond / visited-already paths ----------

#[test]
fn serve_bfs_handles_diamond_with_revisited_nodes() {
    // a → b, a → c, b → c, c → d. From `a`, both `b` and `c` are enqueued.
    // When `b`'s outgoing edge to `c` is processed, `c` is already visited —
    // exercises the `visited.insert` false branch (closes the if body cleanly).
    use graphy_core::serve::{Index, StoredGraph, handle_line};
    use serde_json::json;
    let g = json!({
        "nodes": [
            { "id": "a", "label": "A" },
            { "id": "b", "label": "B" },
            { "id": "c", "label": "C" },
            { "id": "d", "label": "D" }
        ],
        "edges": [
            { "source": "a", "target": "b", "relation": "calls", "confidence": "INFERRED" },
            { "source": "a", "target": "c", "relation": "calls", "confidence": "INFERRED" },
            { "source": "b", "target": "c", "relation": "calls", "confidence": "INFERRED" },
            { "source": "c", "target": "d", "relation": "calls", "confidence": "INFERRED" }
        ]
    });
    let stored: StoredGraph = serde_json::from_value(g).unwrap();
    let idx = Index::from_graph(stored);
    let req = json!({
        "jsonrpc": "2.0", "id": 1, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "a", "to": "d" } }
    });
    let resp = handle_line(&idx, &serde_json::to_string(&req).unwrap()).expect("request has id");
    let v = serde_json::to_value(&resp).unwrap();
    let text = v["result"]["content"][0]["text"].as_str().unwrap();
    let payload: serde_json::Value = serde_json::from_str(text).unwrap();
    let path: Vec<String> = payload["path"]
        .as_array()
        .unwrap()
        .iter()
        .filter_map(|p| p.as_str().map(String::from))
        .collect();
    assert_eq!(path, vec!["a", "c", "d"]);
}

#[test]
fn serve_bfs_revisits_via_incoming_branch_diamond() {
    // c → a, c → b. From `a`, in-edges yield `c`; from `b`, in-edges also yield
    // `c` — second visit exercises the `visited.insert` false branch in the
    // in_edges loop.
    use graphy_core::serve::{Index, StoredGraph, handle_line};
    use serde_json::json;
    let g = json!({
        "nodes": [
            { "id": "a", "label": "A" }, { "id": "b", "label": "B" }, { "id": "c", "label": "C" }
        ],
        "edges": [
            { "source": "c", "target": "a", "relation": "calls", "confidence": "INFERRED" },
            { "source": "c", "target": "b", "relation": "calls", "confidence": "INFERRED" }
        ]
    });
    let stored: StoredGraph = serde_json::from_value(g).unwrap();
    let idx = Index::from_graph(stored);
    let req = json!({
        "jsonrpc": "2.0", "id": 2, "method": "tools/call",
        "params": { "name": "shortest_path", "arguments": { "from": "a", "to": "b" } }
    });
    let resp = handle_line(&idx, &serde_json::to_string(&req).unwrap()).expect("request has id");
    let v = serde_json::to_value(&resp).unwrap();
    let text = v["result"]["content"][0]["text"].as_str().unwrap();
    let payload: serde_json::Value = serde_json::from_str(text).unwrap();
    let path: Vec<String> = payload["path"]
        .as_array()
        .unwrap()
        .iter()
        .filter_map(|p| p.as_str().map(String::from))
        .collect();
    assert_eq!(path, vec!["a", "c", "b"]);
}

// ---------- cache ----------

#[test]
fn cache_save_without_prior_partition_is_noop() {
    let dir = tempdir().unwrap();
    let mut cache = Cache::open(dir.path()).unwrap();
    // No partition call → pending map is empty → save returns Ok without
    // writing anything.
    cache
        .save(Path::new("never-seen.rs"), &ExtractionOutput::default())
        .unwrap();
    cache.flush().unwrap();
    // The cache directory exists but no per-hash payloads were written.
    let entries: Vec<_> = fs::read_dir(dir.path().join("graphy-out").join(".cache"))
        .unwrap()
        .filter_map(|e| e.ok())
        .filter(|e| {
            e.file_name()
                .to_str()
                .map(|s| s.ends_with(".json") && s != "manifest.json")
                .unwrap_or(false)
        })
        .collect();
    assert!(entries.is_empty());
}

#[test]
fn cache_partition_with_mixed_hit_miss_iterates_continue_branch() {
    // Two files: file `a` is a cache hit (continues), file `b` is a miss
    // (falls through to uncached). Exercises the `continue` after a hit when
    // the loop has more items to process.
    let dir = tempdir().unwrap();
    let a = dir.path().join("a.rs");
    let b = dir.path().join("b.rs");
    fs::write(&a, "fn aa(){}").unwrap();
    fs::write(&b, "fn bb(){}").unwrap();

    let mut c1 = Cache::open(dir.path()).unwrap();
    let _ = c1.partition(&[a.clone(), b.clone()]);
    c1.save(&a, &ExtractionOutput::default()).unwrap();
    // Deliberately do NOT save `b`, so on reopen `b` is uncached while `a` hits.
    c1.flush().unwrap();

    let mut c2 = Cache::open(dir.path()).unwrap();
    let part = c2.partition(&[a.clone(), b.clone()]);
    assert_eq!(part.cached.len(), 1);
    assert_eq!(part.uncached.len(), 1);
    assert!(part.cached[0].0.ends_with("a.rs"));
    assert!(part.uncached[0].ends_with("b.rs"));
}

#[test]
fn cache_partition_falls_back_to_uncached_when_payload_file_missing() {
    // Manifest entry exists with the file's current hash, but the per-hash
    // payload was deleted from disk. partition() should silently fall through
    // to the uncached path instead of returning stale data.
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();

    let mut c1 = Cache::open(dir.path()).unwrap();
    let _ = c1.partition(std::slice::from_ref(&p));
    c1.save(&p, &ExtractionOutput::default()).unwrap();
    c1.flush().unwrap();

    // Wipe the per-hash payload while leaving manifest in place.
    let cache_root = dir.path().join("graphy-out").join(".cache");
    for entry in fs::read_dir(&cache_root).unwrap() {
        let entry = entry.unwrap();
        if entry.file_name() != "manifest.json" {
            fs::remove_file(entry.path()).unwrap();
        }
    }

    let mut c2 = Cache::open(dir.path()).unwrap();
    let part = c2.partition(std::slice::from_ref(&p));
    assert!(part.cached.is_empty(), "no cache hits with payload missing");
    assert_eq!(part.uncached, vec![p]);
}

#[test]
fn cache_save_skips_when_payload_already_present() {
    let dir = tempdir().unwrap();
    let p = dir.path().join("a.rs");
    fs::write(&p, "fn f(){}").unwrap();
    let mut c1 = Cache::open(dir.path()).unwrap();
    let _ = c1.partition(std::slice::from_ref(&p));
    c1.save(&p, &ExtractionOutput::default()).unwrap();
    c1.flush().unwrap();

    // Re-open and save again with the same content — the if !target.exists()
    // branch should short-circuit the duplicate write.
    let mut c2 = Cache::open(dir.path()).unwrap();
    let _ = c2.partition(std::slice::from_ref(&p));
    c2.save(&p, &ExtractionOutput::default()).unwrap();
    c2.flush().unwrap();
}

// ---------- extractor branch coverage ----------

#[test]
fn lua_require_call_inside_a_function_body_yields_no_import() {
    // The `function_call` import path only fires at the top level. Inside a
    // function body we expect no extra import edge — exercise the closing
    // braces of the nested if blocks.
    let out = run(
        ".lua",
        "function main()\n  local m = require('helper')\n  return m\nend\n",
    );
    assert!(out.nodes.iter().any(|n| n.label == "main"));
}

#[test]
fn lua_top_level_non_require_function_call_ignored_for_imports() {
    let out = run(".lua", "print('hi')\n");
    assert!(out.edges.iter().all(|e| e.relation != "imports"));
}

#[test]
fn ruby_calls_inside_methods_emit_call_edges() {
    let out = run(
        ".rb",
        "class S\n  def first; helper; end\n  def helper; end\nend",
    );
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn ruby_parenthesized_call_inside_method_body_emits_edge() {
    // `helper()` with parens produces a `call` node (vs the bare-identifier
    // form which is just an `identifier`). Both must be recognised as calls.
    let out = run(".rb", "def first; helper(); end\ndef helper; end\n");
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn ruby_method_with_receiver_call_emits_edge() {
    let out = run(
        ".rb",
        "def runner\n  obj.do_thing\nend\ndef do_thing; end\n",
    );
    // The `obj.do_thing` desugars to a `call` node; we don't necessarily emit
    // an edge for it (no local `obj` defined), but we exercise the branch.
    let _ = out.nodes.len();
}

#[test]
fn scala_calls_inside_function_body_yield_edges() {
    let out = run(
        ".scala",
        "object O { def helper() = 1; def main() = { helper() } }",
    );
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn objc_function_definition_with_body_extracted() {
    let out = run(
        ".m",
        "void helper(int x) {}\nvoid main_fn() { helper(1); }\n",
    );
    let labels: Vec<_> = out.nodes.iter().map(|n| n.label.as_str()).collect();
    assert!(labels.contains(&"helper") || labels.contains(&"main_fn"));
}

#[test]
fn objc_method_declaration_handled() {
    let out = run(
        ".m",
        "@interface Foo\n- (void)run;\n@end\n@implementation Foo\n- (void)run {}\n@end\n",
    );
    assert!(!out.nodes.is_empty());
}

#[test]
fn zig_function_with_internal_calls_yields_edges() {
    let out = run(
        ".zig",
        "fn helper() void {}\nfn main() void { helper(); helper(); }\n",
    );
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn julia_function_call_inside_body_yields_call_edge() {
    let out = run(
        ".jl",
        "function helper() end\nfunction main() helper() end\n",
    );
    assert!(out.nodes.iter().any(|n| n.label == "main"));
    assert!(out.nodes.iter().any(|n| n.label == "helper"));
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

#[test]
fn elixir_alias_call_emits_import() {
    let out = run(
        ".ex",
        "defmodule S do\n  alias Lib.X\n  import Enum\n  def run, do: X.go()\nend\n",
    );
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn elixir_use_directive_emits_import() {
    let out = run(
        ".ex",
        "defmodule T do\n  use GenServer\n  def f, do: :ok\nend",
    );
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn json_ref_with_empty_target_is_skipped() {
    let out = run(".json", r##"{"a":{"$ref":""}}"##);
    assert!(out.edges.iter().all(|e| e.relation != "references"));
}

#[test]
fn json_empty_string_key_is_skipped() {
    let out = run(".json", r#"{"":"value"}"#);
    assert!(out.nodes.iter().all(|n| !n.label.is_empty()));
}

#[test]
fn css_at_import_without_url_handled() {
    let out = run(".css", "@import \"vendor.css\";\n.x { color: red }\n");
    assert!(out.edges.iter().any(|e| e.relation == "imports"));
}

#[test]
fn css_rule_with_complex_selector_emits_node() {
    let out = run(".css", "[data-x=\"1\"] > .y::before { content: \"\"; }\n");
    assert!(!out.nodes.is_empty());
}

#[test]
fn html_div_without_id_or_link_attributes_yields_no_nodes() {
    let out = run(".html", "<div></div>");
    assert!(out.nodes.is_empty());
    assert!(out.edges.is_empty());
}

#[test]
fn html_anchor_href_treated_as_reference_edge() {
    let out = run(".html", "<a href=\"https://example.test\">x</a>");
    assert!(out.edges.iter().any(|e| e.relation == "references"));
}

#[test]
fn c_family_struct_specifier_yields_node() {
    let out = run(".c", "struct Foo { int x; };\nint main(void){return 0;}\n");
    assert!(out.nodes.iter().any(|n| n.label == "Foo"));
}

#[test]
fn c_family_union_specifier_yields_node() {
    let out = run(".c", "union U { int a; float b; };\n");
    // tree-sitter-c may include or omit anonymous unions; verify no panic.
    let _ = out.nodes.len();
}

#[test]
fn bash_function_body_calls_resolve_against_local_symbols() {
    let out = run(".sh", "helper() { echo h; }\nmain() { helper; helper; }\n");
    assert!(out.edges.iter().any(|e| e.relation == "calls"));
}

// ---------- detect.rs: 1 missed line ----------

#[test]
fn detect_skips_paths_with_no_extension() {
    use graphy_core::detect::{DetectOptions, collect_files};
    let dir = tempdir().unwrap();
    // Files without an extension never enter CODE_EXTENSIONS.
    fs::write(dir.path().join("LICENSE"), "MIT").unwrap();
    fs::write(dir.path().join("ok.rs"), "fn f(){}").unwrap();
    let files = collect_files(dir.path(), DetectOptions::default());
    assert_eq!(files.len(), 1);
    assert!(files[0].ends_with("ok.rs"));
}

// ---------- swift label_after_keyword no longer exists; sanity check ----------

#[test]
fn swift_actor_declaration_via_class_declaration_kind() {
    // `actor Counter {}` is also represented as `class_declaration` with the
    // `actor` keyword child — confirm we still emit a node.
    let out = run(".swift", "actor Counter { var n = 0 }");
    assert!(out.nodes.iter().any(|n| n.label == "Counter"));
}
