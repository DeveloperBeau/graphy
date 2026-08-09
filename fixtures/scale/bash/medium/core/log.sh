# Logging with an adjustable level.

CALC_LOG_LEVEL="${CALC_LOG_LEVEL:-info}"

log_write() {
  local level="$1"
  shift
  printf '%s %s\n' "$level" "$*" >&2
}

log_debug() { [[ "$CALC_LOG_LEVEL" == "debug" ]] && log_write DEBUG "$@"; }
log_info() { log_write INFO "$@"; }
