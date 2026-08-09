# Exit codes

inkroll is safe to use in pipelines guarded by `set -e`.

## The codes

Zero on success. Two for an unknown preset name. Three for an unreadable
rules file, which usually means a typo in the path set via the
[configuration file](config-file.md).

## Signals

On SIGPIPE inkroll exits quietly with zero, so closing a pager
downstream is not an error. Anything else unexpected is worth a report
via the steps in [troubleshooting](troubleshooting.md).
