# Graphy Markdown Fixture

A minimal multi-file Markdown project used by `crates/graphy-core/tests/lang_markdown.rs`
to assert the Markdown extractor and full Graphy pipeline emit expected nodes.

## Overview

This fixture covers the Markdown extractor's heading extraction capability.
Each heading becomes a node in the knowledge graph.

## Links

- [Guide](guide.md) - user guide document
- [API Reference](api.md) - API documentation

Note: inline link edges are NOT currently extracted by the extractor.
Links above are present in the fixture but will not produce graph edges.

## Files

| File | Demonstrates |
|---|---|
| `README.md` | H1, H2, H3 headings; cross-file links (not extracted as edges) |
| `guide.md` | H1/H2/H3 headings across multiple sections |
| `api.md` | H1/H2 headings for API sections |
| `empty.md` | empty file edge case |

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_markdown.rs`.
Treat fixture and tests as one unit; change both in the same commit.
