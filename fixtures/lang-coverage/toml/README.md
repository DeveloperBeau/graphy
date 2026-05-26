# TOML language coverage fixture

A minimal multi-file TOML project used by `crates/graphy-core/tests/lang_toml.rs`
to assert the TOML extractor and full Graphy pipeline emit expected nodes.

## Files

| File | Demonstrates |
|---|---|
| `Cargo.toml` | [package] section, nested [package.metadata], [[bin]] array of tables (two instances), [dependencies]/[dev-dependencies] sections, key-value pairs |
| `config.toml` | [server], [database], [logging], [features] sections with key-value pairs |
| `empty.toml` | empty file edge case (zero bytes is valid TOML) |

## Extractor behavior

- `[section]` headers emit `table` nodes
- `[[array]]` headers emit `table_array_element` nodes
- `key = value` pairs emit `pair` nodes
- No cross-file references (TOML has none natively)

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_toml.rs`.
Treat fixture and tests as one unit; change both in the same commit.
