# Leveled logging to stderr.

log_write() {
  local level="$1"
  shift
  printf '[%s] %s\n' "$level" "$*" >&2
}

log_info() { log_write INFO "$@"; }
log_warn() { log_write WARN "$@"; }
log_error() { log_write ERROR "$@"; }
