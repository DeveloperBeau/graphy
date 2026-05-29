//! MCP-style JSON-RPC server over stdio.
//!
//! Loads `graph.json`, then handles JSON-RPC requests one per line on stdin
//! and writes responses to stdout. Exposes a small set of read-only tools
//! useful for an AI client to query the knowledge graph.
//!
//! Supported methods:
//!
//! | method            | params                                  | result                    |
//! |-------------------|-----------------------------------------|---------------------------|
//! | `initialize`      | `{}`                                    | server info               |
//! | `tools/list`      | `{}`                                    | array of tool descriptors |
//! | `tools/call`      | `{ name, arguments }`                   | tool-specific result      |
//!
//! Tools: `stats`, `search_label`, `neighbors`, `shortest_path`, `query_node`.
//!
//! The server tolerates a missing graph file: it serves an empty index and
//! reloads in-process when the graph appears (or changes) on disk. JSON-RPC
//! notifications (requests with no `id`) never receive a response.

use std::collections::{HashMap, HashSet, VecDeque};
use std::io::{BufRead, Write};
use std::path::{Path, PathBuf};
use std::time::SystemTime;

use anyhow::{Context, Result};
use serde::{Deserialize, Serialize};
use serde_json::{Value, json};

#[derive(Debug, Clone, Deserialize)]
pub struct StoredGraph {
    pub nodes: Vec<StoredNode>,
    pub edges: Vec<StoredEdge>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct StoredNode {
    pub id: String,
    pub label: String,
    #[serde(default)]
    pub source_file: Option<String>,
    #[serde(default)]
    pub source_location: Option<String>,
    #[serde(default)]
    pub kind: Option<String>,
    #[serde(default)]
    pub community: Option<u32>,
}

#[derive(Debug, Clone, Deserialize, Serialize)]
pub struct StoredEdge {
    pub source: String,
    pub target: String,
    pub relation: String,
    pub confidence: String,
}

/// Pre-indexed view of a stored graph for fast lookup.
#[derive(Debug)]
pub struct Index {
    pub nodes: HashMap<String, StoredNode>,
    pub label_lookup: Vec<(String, String)>, // (lowercase label, node id)
    pub out_edges: HashMap<String, Vec<StoredEdge>>,
    pub in_edges: HashMap<String, Vec<StoredEdge>>,
}

impl Index {
    pub fn empty() -> Self {
        Self {
            nodes: HashMap::new(),
            label_lookup: Vec::new(),
            out_edges: HashMap::new(),
            in_edges: HashMap::new(),
        }
    }

    pub fn from_graph(g: StoredGraph) -> Self {
        let mut nodes: HashMap<String, StoredNode> = HashMap::with_capacity(g.nodes.len());
        let mut label_lookup: Vec<(String, String)> = Vec::with_capacity(g.nodes.len());
        for n in g.nodes {
            label_lookup.push((n.label.to_lowercase(), n.id.clone()));
            nodes.insert(n.id.clone(), n);
        }
        let mut out_edges: HashMap<String, Vec<StoredEdge>> = HashMap::new();
        let mut in_edges: HashMap<String, Vec<StoredEdge>> = HashMap::new();
        for e in g.edges {
            out_edges
                .entry(e.source.clone())
                .or_default()
                .push(e.clone());
            in_edges.entry(e.target.clone()).or_default().push(e);
        }
        Self {
            nodes,
            label_lookup,
            out_edges,
            in_edges,
        }
    }

    pub fn load(path: &Path) -> Result<Self> {
        let text =
            std::fs::read_to_string(path).with_context(|| format!("read {}", path.display()))?;
        let g: StoredGraph = serde_json::from_str(&text).context("parse graph.json")?;
        Ok(Self::from_graph(g))
    }
}

/// Stat-on-request cache backing the live server. Tracks `(mtime, size)` so
/// rebuilds on filesystems with coarse mtime granularity are still picked up
/// when the file size changes. A missing file resets the cache to empty.
pub struct IndexCache {
    path: PathBuf,
    cached: Option<(SystemTime, u64, Index)>,
    empty: Index,
}

impl IndexCache {
    pub fn new(path: PathBuf) -> Self {
        Self {
            path,
            cached: None,
            empty: Index::empty(),
        }
    }

    /// Returns the freshest available index. Falls back to an empty index when
    /// the file is missing or fails to parse; a stale-but-valid cached index
    /// is retained across transient parse failures so a half-written graph
    /// doesn't blank out the server mid-edit.
    pub fn get(&mut self) -> &Index {
        let meta = std::fs::metadata(&self.path).ok();
        let Some(meta) = meta else {
            self.cached = None;
            return &self.empty;
        };
        let mtime = meta.modified().unwrap_or(SystemTime::UNIX_EPOCH);
        let size = meta.len();
        let reuse = matches!(&self.cached, Some((m, s, _)) if *m == mtime && *s == size);
        if !reuse {
            match Index::load(&self.path) {
                Ok(idx) => self.cached = Some((mtime, size, idx)),
                Err(e) => {
                    eprintln!("graphy serve: reload failed: {e:#}");
                    if self.cached.is_none() {
                        return &self.empty;
                    }
                }
            }
        }
        match &self.cached {
            Some((_, _, idx)) => idx,
            None => &self.empty,
        }
    }
}

/// Parsed JSON-RPC request. We track id presence ourselves (vs. relying on
/// `Option<Value>`) because serde collapses absent and `null` into the same
/// `None`. JSON-RPC §4.1 makes the distinction meaningful: an absent id is a
/// notification (no response, even on error); an explicit `null` id is a real
/// (if discouraged) request.
#[derive(Debug)]
struct Request {
    id: Option<Value>,
    method: String,
    params: Value,
}

impl Request {
    fn from_object(mut obj: serde_json::Map<String, Value>) -> Result<Self> {
        let id = if obj.contains_key("id") {
            Some(obj.remove("id").unwrap_or(Value::Null))
        } else {
            None
        };
        let method = obj
            .remove("method")
            .and_then(|v| match v {
                Value::String(s) => Some(s),
                _ => None,
            })
            .ok_or_else(|| anyhow::anyhow!("request missing `method` string"))?;
        let params = obj.remove("params").unwrap_or(Value::Null);
        Ok(Self { id, method, params })
    }
}

#[derive(Debug, Serialize)]
pub struct Response {
    pub jsonrpc: &'static str,
    pub id: Value,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub result: Option<Value>,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub error: Option<RpcError>,
}

#[derive(Debug, Serialize)]
pub struct RpcError {
    pub code: i32,
    pub message: String,
}

/// Run the server until stdin is closed.
pub fn serve(graph_path: PathBuf) -> Result<()> {
    let mut cache = IndexCache::new(graph_path);
    let stdin = std::io::stdin();
    let mut stdout = std::io::stdout().lock();
    let mut line = String::new();
    let mut reader = stdin.lock();
    loop {
        line.clear();
        let n = reader.read_line(&mut line)?;
        if n == 0 {
            return Ok(());
        }
        let trimmed = line.trim();
        if trimmed.is_empty() {
            continue;
        }
        let idx = cache.get();
        if let Some(response) = handle_line(idx, trimmed) {
            serde_json::to_writer(&mut stdout, &response)?;
            writeln!(&mut stdout)?;
            stdout.flush()?;
        }
    }
}

/// Dispatch one JSON-RPC line. Returns `None` when the request is a
/// notification (no `id`); the server emits nothing in that case, per
/// JSON-RPC 2.0 §4.1.
pub fn handle_line(index: &Index, line: &str) -> Option<Response> {
    // Parse to a raw Value first so we can distinguish absent `id` (notification)
    // from `"id": null` (a real request whose id happens to be null).
    let raw: Value = match serde_json::from_str(line) {
        Ok(v) => v,
        Err(e) => {
            // Parse failure: we cannot classify as notification, so the spec
            // permits a response with id=null.
            return Some(Response {
                jsonrpc: "2.0",
                id: Value::Null,
                result: None,
                error: Some(RpcError {
                    code: -32700,
                    message: format!("parse error: {e}"),
                }),
            });
        }
    };
    let Value::Object(obj) = raw else {
        // Batches and primitives aren't supported; mimic parse-error shape.
        return Some(Response {
            jsonrpc: "2.0",
            id: Value::Null,
            result: None,
            error: Some(RpcError {
                code: -32600,
                message: "request must be a JSON object".into(),
            }),
        });
    };
    let req = match Request::from_object(obj) {
        Ok(r) => r,
        Err(e) => {
            return Some(Response {
                jsonrpc: "2.0",
                id: Value::Null,
                result: None,
                error: Some(RpcError {
                    code: -32600,
                    message: e.to_string(),
                }),
            });
        }
    };
    // Notifications: no response, regardless of dispatch outcome.
    let id = req.id.clone()?;
    Some(match dispatch(index, &req) {
        Ok(value) => Response {
            jsonrpc: "2.0",
            id,
            result: Some(value),
            error: None,
        },
        Err(e) => Response {
            jsonrpc: "2.0",
            id,
            result: None,
            error: Some(RpcError {
                code: -32603,
                message: e.to_string(),
            }),
        },
    })
}

fn dispatch(idx: &Index, req: &Request) -> Result<Value> {
    match req.method.as_str() {
        "initialize" => Ok(json!({
            "protocolVersion": "2024-11-05",
            "capabilities": { "tools": {} },
            "serverInfo": {
                "name": "graphy",
                "version": env!("CARGO_PKG_VERSION"),
            },
        })),
        "tools/list" => Ok(json!({ "tools": tool_descriptors() })),
        "tools/call" => {
            let name = req
                .params
                .get("name")
                .and_then(|v| v.as_str())
                .ok_or_else(|| anyhow::anyhow!("missing tool name"))?;
            let args = req.params.get("arguments").cloned().unwrap_or(json!({}));
            let data = run_tool(idx, name, &args)?;
            // MCP requires tools/call results to carry a `content` array; the
            // structured payload rides as JSON text inside a text block.
            Ok(json!({
                "content": [{ "type": "text", "text": serde_json::to_string(&data)? }]
            }))
        }
        other => Err(anyhow::anyhow!("unknown method: {other}")),
    }
}

fn tool_descriptors() -> Value {
    json!([
        { "name": "stats", "description": "Graph-wide counts.",
          "inputSchema": { "type": "object", "properties": {} } },
        { "name": "search_label", "description": "Substring search over node labels.",
          "inputSchema": { "type": "object",
            "properties": { "q": { "type": "string" }, "limit": { "type": "integer" } },
            "required": ["q"] } },
        { "name": "neighbors", "description": "Outgoing + incoming neighbors of a node id.",
          "inputSchema": { "type": "object",
            "properties": { "id": { "type": "string" } },
            "required": ["id"] } },
        { "name": "query_node", "description": "Full info for a node by id.",
          "inputSchema": { "type": "object",
            "properties": { "id": { "type": "string" } },
            "required": ["id"] } },
        { "name": "shortest_path", "description": "BFS shortest path between two node ids.",
          "inputSchema": { "type": "object",
            "properties": { "from": { "type": "string" }, "to": { "type": "string" } },
            "required": ["from", "to"] } },
    ])
}

fn run_tool(idx: &Index, name: &str, args: &Value) -> Result<Value> {
    match name {
        "stats" => Ok(json!({
            "nodes": idx.nodes.len(),
            "edges": idx.out_edges.values().map(|v| v.len()).sum::<usize>(),
            "communities": idx.nodes.values()
                .filter_map(|n| n.community)
                .collect::<std::collections::HashSet<_>>()
                .len(),
        })),
        "search_label" => {
            let q = args
                .get("q")
                .and_then(|v| v.as_str())
                .unwrap_or("")
                .to_lowercase();
            let limit = args.get("limit").and_then(|v| v.as_u64()).unwrap_or(20) as usize;
            let mut out = Vec::with_capacity(limit);
            for (lbl, id) in &idx.label_lookup {
                if lbl.contains(&q) {
                    if let Some(n) = idx.nodes.get(id) {
                        out.push(json!({
                            "id": n.id, "label": n.label,
                            "source_file": n.source_file,
                            "source_location": n.source_location,
                        }));
                    }
                    if out.len() >= limit {
                        break;
                    }
                }
            }
            Ok(json!({ "matches": out }))
        }
        "neighbors" => {
            let id = args
                .get("id")
                .and_then(|v| v.as_str())
                .ok_or_else(|| anyhow::anyhow!("missing id"))?;
            if !idx.nodes.contains_key(id) {
                return Err(anyhow::anyhow!("unknown node: {id}"));
            }
            let out = idx.out_edges.get(id).cloned().unwrap_or_default();
            let inc = idx.in_edges.get(id).cloned().unwrap_or_default();
            Ok(json!({
                "outgoing": out.iter().map(|e| json!({
                    "target": e.target, "relation": e.relation,
                    "confidence": e.confidence,
                })).collect::<Vec<_>>(),
                "incoming": inc.iter().map(|e| json!({
                    "source": e.source, "relation": e.relation,
                    "confidence": e.confidence,
                })).collect::<Vec<_>>(),
            }))
        }
        "query_node" => {
            let id = args
                .get("id")
                .and_then(|v| v.as_str())
                .ok_or_else(|| anyhow::anyhow!("missing id"))?;
            let n = idx
                .nodes
                .get(id)
                .ok_or_else(|| anyhow::anyhow!("unknown node: {id}"))?;
            Ok(serde_json::to_value(n)?)
        }
        "shortest_path" => {
            let from = args
                .get("from")
                .and_then(|v| v.as_str())
                .ok_or_else(|| anyhow::anyhow!("missing from"))?;
            let to = args
                .get("to")
                .and_then(|v| v.as_str())
                .ok_or_else(|| anyhow::anyhow!("missing to"))?;
            let path = bfs_path(idx, from, to);
            Ok(json!({ "path": path }))
        }
        other => Err(anyhow::anyhow!("unknown tool: {other}")),
    }
}

fn bfs_path(idx: &Index, from: &str, to: &str) -> Vec<String> {
    if !idx.nodes.contains_key(from) || !idx.nodes.contains_key(to) {
        return Vec::new();
    }
    if from == to {
        return vec![from.to_string()];
    }
    let mut parent: HashMap<String, String> = HashMap::new();
    let mut visited: HashSet<String> = HashSet::from([from.to_string()]);
    let mut queue: VecDeque<String> = VecDeque::from([from.to_string()]);
    while let Some(cur) = queue.pop_front() {
        // Use both outgoing and incoming for an undirected BFS.
        for e in idx.out_edges.get(&cur).into_iter().flatten() {
            if visited.insert(e.target.clone()) {
                parent.insert(e.target.clone(), cur.clone());
                if e.target == to {
                    return reconstruct(parent, from, to);
                }
                queue.push_back(e.target.clone());
            }
        }
        for e in idx.in_edges.get(&cur).into_iter().flatten() {
            if visited.insert(e.source.clone()) {
                parent.insert(e.source.clone(), cur.clone());
                if e.source == to {
                    return reconstruct(parent, from, to);
                }
                queue.push_back(e.source.clone());
            }
        }
    }
    Vec::new()
}

fn reconstruct(parent: HashMap<String, String>, from: &str, to: &str) -> Vec<String> {
    let mut path = vec![to.to_string()];
    let mut cur = to.to_string();
    while cur != from {
        let Some(p) = parent.get(&cur).cloned() else {
            return Vec::new();
        };
        path.push(p.clone());
        cur = p;
    }
    path.reverse();
    path
}
