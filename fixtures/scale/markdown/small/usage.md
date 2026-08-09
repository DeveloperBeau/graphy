# Everyday usage

The common case is piping a noisy command through inkroll with a preset:

    tail -f build.log | inkroll --preset build

## Composing presets

Presets stack left to right, so later ones win where they overlap.
The presets themselves are described in the [preset list](presets.md),
and the flags in [styles and flags](styles.md).

## Where output goes

Styled text goes to stdout; diagnostics go to stderr, coded as listed in
[exit codes](exit-codes.md).
