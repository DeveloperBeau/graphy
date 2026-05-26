# HTML language coverage fixture

A minimal multi-file HTML project used by `crates/graphy-core/tests/lang_html.rs`
to assert the HTML extractor and full Graphy pipeline emit expected nodes and edges.

## Files

| File | Demonstrates |
|---|---|
| `index.html` | id-bearing elements (main, nav, content, footer), href link to about.html, link stylesheet, script src |
| `about.html` | id-bearing elements (section, contact), href back to index.html, link stylesheet |
| `styles.css` | referenced file (not HTML; pipeline processes as CSS) |
| `empty.html` | empty file edge case |

## Extractor behavior

- Elements with `id` attribute emit a node (kind = tag name, label = `tag#id`)
- `href` and `src` attributes emit a `references` edge with target `link::<value>`
- No cross-file resolution by the extractor; edges are unresolved `link::` strings

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_html.rs`.
Treat fixture and tests as one unit; change both in the same commit.
