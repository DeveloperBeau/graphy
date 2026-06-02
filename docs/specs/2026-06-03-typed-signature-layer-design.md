# Typed signature layer

Status: design approved. Pilot scope: Rust built-in extractor.

## Goal

Add a structural layer to the knowledge graph that captures function, class, and
variable signatures where the grammar expresses types. Two outputs per node:

1. **Typed edges** to type nodes, so the graph answers "who takes, returns, or has
   a field of type `T`".
2. **A structured signature payload** on each function/class node, so a reader (or
   Claude over MCP) gets the exact parameter and return types without opening the file.

Languages whose grammar carries no type information emit the structural nodes they
can (functions, params by name) and record the gap in a per-language coverage matrix.

## Non-goals

- No parameter or field reification. Parameters and fields are edge metadata plus
  signature payload, not their own nodes.
- No body-level type inference. `references` edges for in-body type usage stay as
  they are; this work only reclassifies signature-position types.
- No new query language. The existing MCP tools (`neighbors`, `query_node`) surface
  the new data.

## Data model

### Node kinds

One new kind: `type`. A type referenced in a signature becomes a node with id
`extern::<TypePath>`, generic arguments stripped (the Rust extractor already strips
them for `implements` edges). Dedup collapses `extern::Foo` onto a local `struct` /
`enum` / `trait` / `class` / `type_alias` definition named `Foo` when one exists,
using the existing extern-to-def resolution. With no local definition it stays
`extern::`.

### Edge relations

Three new relations, all `EXTRACTED` confidence:

| Relation | From | To | Metadata |
|----------|------|----|----------|
| `has_param` | function | type | `{name, index}` |
| `returns` | function | type | none |
| `has_field` | struct/class | type | `{name}` |

`inherits` and `implements` already exist and are unchanged.

### Edge metadata

`EdgeData` and `schema::Edge` gain `attr: Option<EdgeAttr>`:

```rust
pub struct EdgeAttr {
    pub name: Option<String>,   // param or field name
    pub index: Option<u32>,     // param position, 0-based
}
```

Serde skips empty fields. Existing edges serialize unchanged (no `attr` key).

### Node signature payload

`schema::Node` and `graph::NodeData` gain `signature: Option<Signature>`:

```rust
pub struct Signature {
    pub params: Vec<ParamSig>,   // functions
    pub returns: Option<String>, // textual return type, None if absent
    pub fields: Vec<FieldSig>,   // structs/classes
}
pub struct ParamSig { pub name: String, pub ty: Option<String> }
pub struct FieldSig { pub name: String, pub ty: Option<String> }
```

`ty` is the textual type as written in source (`&str`, `Result<Ast>`). It is `None`
where the grammar carries no type for that position. `params`/`fields` default empty
and are skipped when empty.

## Refine: existing `references` edges

`rust.rs::emit_references_edges` (rust.rs:193) currently emits `references` edges
from a function to every type in its parameters and return. This work splits that:

- Each parameter type emits `has_param` to `extern::<Type>` with `{name, index}`.
- The return type emits `returns` to `extern::<Type>`.
- `references` is reserved for body-level type usage. The Rust extractor emits no
  body-level references today, so after this change `references` is sparse until a
  later body-walk pass adds them. This reclassifies signature edges; it does not drop
  graph information.

The same walk that emits the edges builds the `Signature` payload, so the textual
types and the type nodes come from one traversal.

## Schema and plumbing

| File | Change |
|------|--------|
| `schema.rs` | Add `Signature`, `ParamSig`, `FieldSig`, `EdgeAttr`. Add `signature` to `Node`, `attr` to `Edge`. |
| `graph.rs` | Add `signature` to `NodeData`, `attr` to `EdgeData`. Carry both in `add_node_record` (graph.rs:44) and `add_edge_record` (graph.rs:58). Emit both in `to_json_value` (graph.rs:106, graph.rs:123). |
| `dedup/map.rs` | No change to edge retargeting: typed edges to `extern::Foo` redirect to the canonical def through the existing source/target rewrite (map.rs:72). On a node merge the canonical node keeps its `signature`. |
| `serve.rs` | Add `signature` to the served node struct so `query_node` returns it. Add `attr` to the served `Edge` (serve.rs:52) so `neighbors` shows param name and index. |
| `export.rs` | Render the signature on node hover in the HTML viewer. Low priority; can land in a follow-up. |

`graph.json` changes are additive. Existing consumers that ignore unknown keys keep
working.

## Capability matrix

New doc `docs/type-layer-coverage.md`. One row per language, columns `params`,
`returns`, `fields`, each marked `full` / `partial` / `none`, plus a note on the
limitation. Examples:

| Language | params | returns | fields | Note |
|----------|--------|---------|--------|------|
| Rust | full | full | full | pilot |
| Go, Java, C#, TypeScript, C++, Swift, Kotlin, Scala | full | full | full | static types |
| Python | partial | partial | partial | only when annotations present |
| JavaScript, Ruby, Lua, Bash | none | none | none | grammar has no type info |

The doc also holds the node-kind and edge-relation legend. Each later grammar PR fills
its row.

## Testing

- `lang_coverage` harness: per-language assertions for `has_param` / `returns` /
  `has_field` edges and the `signature` payload, on the Rust fixture first.
- Dedup: a `has_param` edge to `extern::Foo` collapses onto a local `Foo` def.
- Serve e2e: `query_node` returns the `signature`; `neighbors` carries `attr`.
- Schema roundtrip: `Node`/`Edge` with the new fields serialize and deserialize, and
  old `graph.json` without the fields still loads.

## Rollout

- **PR 1 (this spec):** model, schema, Rust extractor (Refine), graph/dedup/serve
  plumbing, capability-matrix scaffold with the Rust row, tests. Built-in extractors
  only.
- **PR 2..N:** one grammar or a small tier per PR, each filling its matrix row.
- **Plugin-crate parity:** the 37 cdylib plugin crates duplicate extractor logic.
  They mirror the built-in changes in a later tracked tier, after the built-in model
  proves out.

## Open risks

- **Edge metadata reaches every edge.** `attr` is `Option`, so non-typed edges pay
  one `None` per edge. Acceptable; verify `graph.json` size on a large fixture.
- **Generic and nested types.** Stripping generic args (`Vec<Foo>` to `Vec`) loses
  the inner type for the node id. The signature payload keeps the full textual type,
  so the detail is not lost, only the node-level edge points at the outer type. Inner
  types as separate edges are a later refinement.
- **`references` sparseness.** After Refine, `references` is near-empty for Rust until
  a body-walk pass lands. Note this in the capability matrix so it does not read as a
  regression.
