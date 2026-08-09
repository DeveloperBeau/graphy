# Bench tuning knobs with environment overrides.

BENCH_WARMUP="${CIPHBENCH_WARMUP:-2}"
BENCH_VERBOSE="${CIPHBENCH_VERBOSE:-0}"

config_get() {
  case "$1" in
    warmup) echo "$BENCH_WARMUP" ;;
    verbose) echo "$BENCH_VERBOSE" ;;
    *) return 1 ;;
  esac
}

config_is_verbose() {
  [[ "$BENCH_VERBOSE" == "1" ]]
}
