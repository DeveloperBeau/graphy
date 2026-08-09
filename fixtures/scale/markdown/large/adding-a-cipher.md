# Adding a cipher

New entries are plain C files that implement the four harness entry
points: key setup, encrypt, decrypt and teardown.

## Registration

Add the descriptor to the suite table and a chapter page next to the
existing ones — the [cipher index](cipher-index.md) is generated from
the table, so the page name must match the descriptor slug.

## Acceptance

A new entry needs three clean nightly runs across the fleet in
[hardware notes](hardware.md) before its figures are treated as stable,
per the rules in [how runs work](methodology.md).
