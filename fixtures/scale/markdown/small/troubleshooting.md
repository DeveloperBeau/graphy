# Troubleshooting

Most surprises are terminal quirks, not bugs.

## Colours look wrong

Check `TERM` first; a 16-colour terminal quantises the palette from
[colour rules](colour-rules.md) noticeably.

## Wrapped lines misalign

Double-width characters confused older releases; upgrade to 1.6 or
later, per the [changelog](changelog.md).

## Still stuck

The [FAQ](faq.md) covers the rest; include `inkroll --version` output
in any report.
