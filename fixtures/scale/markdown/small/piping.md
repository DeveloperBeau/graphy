# Piping patterns

Three complete setups you can copy into a shell profile.

## Compiler output

    gcc 2>&1 | inkroll --preset build --width 100

## Server logs

    journalctl -f | inkroll --preset server

## Column data

`inkroll --no-wrap` keeps wide CSV rows intact, as explained on the
[wrapping page](wrapping.md). Preset details are in the
[preset list](presets.md).
