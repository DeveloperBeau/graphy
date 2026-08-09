# Running the harness

`cipherbench run` executes the full suite on the current machine and
appends every pass to the store. A run of the full suite takes around
forty minutes on the desktop part.

## Useful flags

`--only aes,chacha20` restricts the suite, `--passes 20` raises the
pass count beyond the default described in [how runs work](methodology.md),
and `--tag` attaches a free-form label that later shows up in exports
from [the results store](results-store.md).

## Scheduling

The fleet machines run the suite nightly from cron; anything submitted
by hand should use `--tag adhoc` so the nightly baselines stay clean.
