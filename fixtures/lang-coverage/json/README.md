# JSON language coverage fixture

A minimal multi-file JSON project used by `crates/graphy-core/tests/lang_json.rs`
to assert the JSON extractor and full Graphy pipeline emit expected nodes and edges.

## Files

| File | Demonstrates |
|---|---|
| `config.json` | top-level keys (name, version, description), nested object keys (scripts.test/build, dependencies.serde/anyhow), $ref edge to schema.json |
| `schema.json` | JSON Schema document: $schema, title, type, definitions/Config, properties, required |
| `empty.json` | empty valid JSON object `{}` (NOT zero bytes - zero bytes is invalid JSON) |

## Extractor behavior

- Every JSON key at any depth emits a `json_key` node
- A key named `$ref` emits a `references` edge with target `ref::<value>`
- Arrays produce no nodes (no keys)
- The empty fixture must be `{}` (valid JSON with no keys)

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_json.rs`.
Treat fixture and tests as one unit; change both in the same commit.
