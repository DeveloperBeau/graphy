# SQL language coverage fixture

A minimal multi-file SQL project used by `crates/graphy-core/tests/lang_sql.rs`
to assert the SQL extractor and full Graphy pipeline emit expected nodes.

## Files

| File | Demonstrates |
|---|---|
| `schema.sql` | CREATE TABLE (users, posts, comments), CREATE INDEX, CREATE VIEW |
| `queries.sql` | DML (SELECT, INSERT, UPDATE, DELETE) - these produce NO graph nodes |
| `empty.sql` | empty file edge case |

## Extractor behavior

- DDL-only: only CREATE TABLE/VIEW/INDEX/FUNCTION/PROCEDURE produce nodes
- DML (SELECT/INSERT/UPDATE/DELETE) produces no nodes or edges
- No cross-file references (SQL files are self-contained in this harness)
- No FOREIGN KEY or JOIN edges emitted; cross-table relationships not tracked

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_sql.rs`.
Treat fixture and tests as one unit; change both in the same commit.
