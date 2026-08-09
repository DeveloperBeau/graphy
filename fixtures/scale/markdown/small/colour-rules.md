# Colour rules

Rules are named patterns with a colour each, one per line in a plain
text file loaded with `--rules`.

## Rule syntax

A rule is pattern, colon, colour name. Comments start with a hash.
Sixteen colour names map onto the terminal palette.

## Precedence

File rules run after preset rules, so they win on overlap — the same
ordering presets themselves use in [everyday usage](usage.md). Defaults
can be set permanently in the [configuration file](config-file.md).
