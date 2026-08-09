# The history tape

Every evaluated expression is appended to a tape file together with its
result and a timestamp. The tape survives restarts.

## Searching the tape

`history 20` prints the last twenty entries; `history /sqrt/` prints
entries whose expression matches the pattern between the slashes.

## Replaying an entry

`redo 12` re-evaluates entry twelve under the current settings, which
matters when settings have changed since; see
[precision and rounding](precision.md) for how results can differ. The
tape can also be written out, per [exporting the tape](exporting.md).
