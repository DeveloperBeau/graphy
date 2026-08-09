# Timestamped logging for bench runs.

log_write() {
  local level="$1"
  shift
  printf '%(%H:%M:%S)T [%s] %s\n' -1 "$level" "$*" >&2
}

log_info() { log_write INFO "$@"; }
log_warn() { log_write WARN "$@"; }
log_error() { log_write ERROR "$@"; }
