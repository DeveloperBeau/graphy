# inkroll

A small command line tool that wraps, indents and colours text on its way
to the terminal. It reads from stdin, applies a style, and writes to stdout.

Start with the [installation guide](installation.md), then work through
[everyday usage](usage.md). The full flag reference lives in
[styles and flags](styles.md), and the built-in styles are described in
the [preset list](presets.md).

## Why another formatter

Most pagers style whole documents. inkroll styles streams: log tails,
compiler output, anything that arrives line by line and needs to stay
readable while it scrolls. The [piping patterns](piping.md) page shows
the common setups.
