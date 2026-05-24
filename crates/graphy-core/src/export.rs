//! Write `graphy-out/{graph.json, GRAPH_REPORT.md, graph.html}`.

use std::fs;
use std::path::Path;

use anyhow::{Context, Result};

use crate::analyze::Analysis;
use crate::graph::KnowledgeGraph;
use crate::report;

pub const OUT_DIR_NAME: &str = "graphy-out";

#[derive(Debug, Clone)]
pub struct ExportPaths {
    pub graph_json: std::path::PathBuf,
    pub report_md: std::path::PathBuf,
    pub graph_html: std::path::PathBuf,
}

pub fn export(out_root: &Path, g: &KnowledgeGraph, a: &Analysis) -> Result<ExportPaths> {
    let out = out_root.join(OUT_DIR_NAME);
    fs::create_dir_all(&out)
        .with_context(|| format!("mkdir {}", out.display()))?;

    let graph_json = out.join("graph.json");
    let report_md = out.join("GRAPH_REPORT.md");
    let graph_html = out.join("graph.html");

    fs::write(
        &graph_json,
        serde_json::to_vec_pretty(&g.to_json_value())?,
    )?;
    fs::write(&report_md, report::render(g, a))?;
    fs::write(&graph_html, render_html(g, a))?;

    Ok(ExportPaths {
        graph_json,
        report_md,
        graph_html,
    })
}

pub(crate) fn render_html(g: &KnowledgeGraph, a: &Analysis) -> String {
    let data = g.to_json_value();
    let data_json = serde_json::to_string(&data).unwrap_or_else(|_| "{}".into());
    format!(
        r#"<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8" />
<title>graphy — {nodes} nodes / {edges} edges</title>
<style>
  :root {{
    --bg: #0f1115; --fg: #e8eaed; --muted: #8a8f98; --accent: #7aa2f7;
    --panel: #161a23; --line: rgba(255,255,255,0.08);
  }}
  html, body {{ margin: 0; padding: 0; background: var(--bg); color: var(--fg);
    font: 13px/1.4 -apple-system, system-ui, "SF Pro", sans-serif; overflow: hidden;
    height: 100%; }}
  #app {{ display: grid; grid-template-columns: 1fr 320px; height: 100vh; }}
  #canvas-wrap {{ position: relative; overflow: hidden; }}
  svg {{ display: block; width: 100%; height: 100%; cursor: grab; }}
  svg.dragging {{ cursor: grabbing; }}
  .link {{ stroke: var(--line); stroke-width: 1px; }}
  .link.calls {{ stroke: rgba(122,162,247,0.45); }}
  .link.imports {{ stroke: rgba(158,206,106,0.45); }}
  .link.references {{ stroke: rgba(247,118,142,0.4); }}
  .node circle {{ stroke: rgba(0,0,0,0.6); stroke-width: 1px; }}
  .node text {{ font-size: 10px; fill: var(--fg); pointer-events: none;
    paint-order: stroke; stroke: var(--bg); stroke-width: 3px; }}
  .node.highlight circle {{ stroke: var(--accent); stroke-width: 2.5px; }}
  .node.dim {{ opacity: 0.12; }}
  .link.dim {{ opacity: 0.06; }}
  aside {{ background: var(--panel); border-left: 1px solid var(--line);
    padding: 14px 16px; overflow-y: auto; }}
  aside h1 {{ font-size: 14px; margin: 0 0 8px 0; letter-spacing: 0.04em;
    text-transform: uppercase; color: var(--muted); font-weight: 600; }}
  aside h2 {{ font-size: 13px; margin: 18px 0 6px 0; }}
  aside .kv {{ display: flex; justify-content: space-between;
    border-bottom: 1px solid var(--line); padding: 4px 0; font-variant-numeric: tabular-nums; }}
  aside .kv span:first-child {{ color: var(--muted); }}
  aside input[type=search] {{ width: 100%; padding: 6px 8px; background: #1f2533;
    border: 1px solid var(--line); color: var(--fg); border-radius: 4px; box-sizing: border-box; }}
  aside .result {{ padding: 4px 0; cursor: pointer; border-bottom: 1px solid var(--line); }}
  aside .result:hover {{ color: var(--accent); }}
  aside .legend span {{ display: inline-block; width: 10px; height: 10px;
    margin-right: 5px; vertical-align: -1px; border-radius: 50%; }}
  aside #selected {{ font-size: 12px; }}
  aside #selected .label {{ color: var(--accent); font-weight: 600; word-break: break-all; }}
  aside #selected .neighbors {{ margin-top: 8px; }}
  aside #selected .neighbors div {{ padding: 2px 0; cursor: pointer;
    color: var(--muted); border-bottom: 1px dotted rgba(255,255,255,0.04); }}
  aside #selected .neighbors div:hover {{ color: var(--fg); }}
</style>
</head>
<body>
<div id="app">
  <div id="canvas-wrap"><svg id="svg"></svg></div>
  <aside>
    <h1>graphy</h1>
    <div class="kv"><span>nodes</span><strong>{nodes}</strong></div>
    <div class="kv"><span>edges</span><strong>{edges}</strong></div>
    <div class="kv"><span>communities</span><strong>{communities}</strong></div>

    <h2>Search</h2>
    <input id="q" type="search" placeholder="filter by label…" />
    <div id="results"></div>

    <h2>Legend</h2>
    <div class="legend">
      <div><span style="background:rgba(122,162,247,0.7)"></span> calls</div>
      <div><span style="background:rgba(158,206,106,0.7)"></span> imports</div>
      <div><span style="background:rgba(247,118,142,0.7)"></span> references</div>
    </div>

    <h2>Selected</h2>
    <div id="selected"><span style="color:var(--muted)">click a node…</span></div>
  </aside>
</div>

<script>
const DATA = {data};
(function() {{
  const svg = document.getElementById("svg");
  const wrap = document.getElementById("canvas-wrap");
  const W = () => wrap.clientWidth;
  const H = () => wrap.clientHeight;

  // Build adjacency.
  const nodes = DATA.nodes.map(n => ({{...n}}));
  const byId = Object.fromEntries(nodes.map(n => [n.id, n]));
  const edges = DATA.edges
    .filter(e => byId[e.source] && byId[e.target])
    .map(e => ({{...e}}));
  const adj = Object.fromEntries(nodes.map(n => [n.id, new Set()]));
  for (const e of edges) {{
    adj[e.source].add(e.target);
    adj[e.target].add(e.source);
  }}

  // Community color palette (sampled HSL).
  const palette = i => `hsl(${{(i * 47) % 360}}, 65%, 55%)`;

  // Place nodes on a grid first as initial layout, then run a few seconds of
  // force-directed relaxation. Keeping the simulation hand-rolled avoids
  // pulling in D3 over the network.
  const N = nodes.length;
  const cols = Math.ceil(Math.sqrt(N));
  nodes.forEach((n, i) => {{
    n.x = ((i % cols) + 0.5) * (W() / cols);
    n.y = (Math.floor(i / cols) + 0.5) * (H() / Math.ceil(N / cols));
    n.vx = 0; n.vy = 0;
  }});

  function tick() {{
    const k = 0.04, repulse = 600, link = 60;
    // Repulsion (O(N^2) — fine up to a few thousand nodes).
    for (let i = 0; i < N; i++) {{
      for (let j = i + 1; j < N; j++) {{
        const a = nodes[i], b = nodes[j];
        let dx = b.x - a.x, dy = b.y - a.y, d2 = dx*dx + dy*dy + 0.01;
        const f = repulse / d2;
        const dxn = dx / Math.sqrt(d2), dyn = dy / Math.sqrt(d2);
        a.vx -= f * dxn; a.vy -= f * dyn;
        b.vx += f * dxn; b.vy += f * dyn;
      }}
    }}
    // Spring attraction.
    for (const e of edges) {{
      const a = byId[e.source], b = byId[e.target];
      let dx = b.x - a.x, dy = b.y - a.y, d = Math.sqrt(dx*dx + dy*dy + 0.01);
      const f = (d - link) * 0.02;
      const fx = (dx / d) * f, fy = (dy / d) * f;
      a.vx += fx; a.vy += fy; b.vx -= fx; b.vy -= fy;
    }}
    // Centering + damping.
    const cx = W() / 2, cy = H() / 2;
    for (const n of nodes) {{
      n.vx = (n.vx + (cx - n.x) * 0.001) * 0.85;
      n.vy = (n.vy + (cy - n.y) * 0.001) * 0.85;
      n.x += n.vx; n.y += n.vy;
    }}
  }}

  // Pan + zoom.
  let tx = 0, ty = 0, scale = 1;
  let dragging = false, lastX = 0, lastY = 0;
  svg.addEventListener("mousedown", e => {{ dragging = true; lastX = e.clientX; lastY = e.clientY; svg.classList.add("dragging"); }});
  window.addEventListener("mouseup", () => {{ dragging = false; svg.classList.remove("dragging"); }});
  window.addEventListener("mousemove", e => {{
    if (!dragging) return;
    tx += e.clientX - lastX; ty += e.clientY - lastY;
    lastX = e.clientX; lastY = e.clientY;
    requestAnimationFrame(render);
  }});
  svg.addEventListener("wheel", e => {{
    e.preventDefault();
    const factor = Math.exp(-e.deltaY * 0.0015);
    const rect = svg.getBoundingClientRect();
    const px = e.clientX - rect.left, py = e.clientY - rect.top;
    tx = px - (px - tx) * factor;
    ty = py - (py - ty) * factor;
    scale *= factor;
    requestAnimationFrame(render);
  }}, {{ passive: false }});

  let selectedId = null;
  function highlight(id) {{
    selectedId = id;
    const neighbours = id ? adj[id] : null;
    document.querySelectorAll(".node").forEach(el => {{
      const nid = el.getAttribute("data-id");
      el.classList.toggle("highlight", nid === id);
      el.classList.toggle("dim", id && nid !== id && !neighbours.has(nid));
    }});
    document.querySelectorAll(".link").forEach(el => {{
      const s = el.getAttribute("data-source"), t = el.getAttribute("data-target");
      el.classList.toggle("dim", id && s !== id && t !== id);
    }});
    const sel = document.getElementById("selected");
    if (!id) {{ sel.innerHTML = '<span style="color:var(--muted)">click a node…</span>'; return; }}
    const n = byId[id];
    const neigh = [...neighbours].map(nid => byId[nid]).filter(Boolean);
    sel.innerHTML = `
      <div class="label">${{escape(n.label)}}</div>
      <div style="color:var(--muted)">${{escape(n.source_file || "")}} ${{escape(n.source_location || "")}}</div>
      <div style="color:var(--muted); margin-top:4px">kind: ${{escape(n.kind || "—")}}</div>
      <div class="neighbors">${{neigh.map(m =>
        `<div data-id="${{escape(m.id)}}">↳ ${{escape(m.label)}}</div>`
      ).join("")}}</div>`;
    sel.querySelectorAll("[data-id]").forEach(el => {{
      el.addEventListener("click", () => highlight(el.getAttribute("data-id")));
    }});
  }}

  function escape(s) {{
    return String(s).replace(/[&<>"']/g, c => ({{"&":"&amp;","<":"&lt;",">":"&gt;","\"":"&quot;","'":"&#39;"}})[c]);
  }}

  // Search panel.
  const qInput = document.getElementById("q");
  const results = document.getElementById("results");
  qInput.addEventListener("input", () => {{
    const q = qInput.value.toLowerCase();
    if (!q) {{ results.innerHTML = ""; return; }}
    const matches = nodes.filter(n => n.label.toLowerCase().includes(q)).slice(0, 12);
    results.innerHTML = matches.map(n =>
      `<div class="result" data-id="${{escape(n.id)}}">${{escape(n.label)}}</div>`
    ).join("");
    results.querySelectorAll(".result").forEach(el => {{
      el.addEventListener("click", () => highlight(el.getAttribute("data-id")));
    }});
  }});

  // Render loop.
  function render() {{
    let svgHtml = "";
    for (const e of edges) {{
      const a = byId[e.source], b = byId[e.target];
      svgHtml += `<line class="link ${{escape(e.relation)}}" data-source="${{escape(e.source)}}" data-target="${{escape(e.target)}}" x1="${{a.x*scale+tx}}" y1="${{a.y*scale+ty}}" x2="${{b.x*scale+tx}}" y2="${{b.y*scale+ty}}"/>`;
    }}
    for (const n of nodes) {{
      const r = 4 + Math.min(8, (adj[n.id].size || 0) / 2);
      const color = palette(n.community ?? 0);
      svgHtml += `<g class="node" data-id="${{escape(n.id)}}" transform="translate(${{n.x*scale+tx}},${{n.y*scale+ty}})">
        <circle r="${{r}}" fill="${{color}}"/>
        <text x="${{r+2}}" y="3">${{escape(n.label.slice(0, 32))}}</text>
      </g>`;
    }}
    svg.innerHTML = svgHtml;
    svg.querySelectorAll(".node").forEach(el => {{
      el.addEventListener("click", e => {{
        e.stopPropagation();
        highlight(el.getAttribute("data-id"));
      }});
    }});
    if (selectedId) highlight(selectedId);
  }}

  // Run sim for a fixed number of ticks (synchronous; quick for small graphs,
  // chunked for larger).
  let ticks = N > 800 ? 60 : N > 200 ? 120 : 200;
  function step() {{
    for (let i = 0; i < 10 && ticks > 0; i++) {{ tick(); ticks--; }}
    render();
    if (ticks > 0) requestAnimationFrame(step);
  }}
  step();
}})();
</script>
</body>
</html>
"#,
        nodes = a.node_count,
        edges = a.edge_count,
        communities = a.community_count,
        data = data_json,
    )
}
