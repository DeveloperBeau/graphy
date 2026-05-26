# CSS language coverage fixture

A minimal multi-file CSS project used by `crates/graphy-core/tests/lang_css.rs`
to assert the CSS extractor and full Graphy pipeline emit expected nodes and edges.

## Files

| File | Demonstrates |
|---|---|
| `main.css` | @import of theme.css and components.css, element/id/class/compound/pseudo selectors, @media block |
| `theme.css` | :root custom properties, element and compound selectors |
| `components.css` | class selectors (.btn, .btn-primary), id selector (#nav), pseudo-class (:active) |
| `empty.css` | empty file edge case |

## Extractor behavior

- CSS rule_set nodes produce `selector` nodes (label = full selector text)
- `@import` statements produce `imports` edges with target `css::<path>`
- No cross-file resolution; @import targets are unresolved `css::` strings

## Maintenance

Edits to this fixture WILL break tests in `crates/graphy-core/tests/lang_css.rs`.
Treat fixture and tests as one unit; change both in the same commit.
