# YAML language coverage fixture

A minimal multi-file YAML project used by `crates/graphy-core/tests/lang_yaml.rs`
to assert the YAML extractor and full Graphy pipeline emit expected nodes.

## Files

| File | Demonstrates |
|---|---|
| `config.yaml` | top-level keys (name, version, description), nested mapping keys (server.host/port, database.host/port/name, logging.level/format) |
| `anchors.yaml` | YAML anchors (&defaults) and aliases (*defaults) with merge key (<<) - keys emitted as nodes; anchor/alias edges NOT emitted by extractor |
| `empty.yaml` | empty file edge case (zero bytes is valid YAML) |

## Extractor behavior

- Every YAML mapping key at any depth emits a `yaml_key` node
- Anchor/alias references do NOT produce edges (extractor limitation, deferred)
- Merge key `<<` is emitted as a `yaml_key` node
- No cross-file references

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_yaml.rs`.
Treat fixture and tests as one unit; change both in the same commit.
