# Calculator settings.

CALC_BASE="${CALC_BASE:-10}"
CALC_PRECISION="${CALC_PRECISION:-0}"

config_get() {
  case "$1" in
    base) echo "$CALC_BASE" ;;
    precision) echo "$CALC_PRECISION" ;;
    *) return 1 ;;
  esac
}

config_set_base() {
  CALC_BASE="$1"
}
