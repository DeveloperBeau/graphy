# Command-line flag handling.

BENCH_ROUNDS=16
BENCH_SAMPLE_SIZE=512

parse_args() {
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --rounds) BENCH_ROUNDS="$2"; shift 2 ;;
      --size) BENCH_SAMPLE_SIZE="$2"; shift 2 ;;
      *) shift ;;
    esac
  done
}

args_summary() {
  echo "rounds=$BENCH_ROUNDS size=$BENCH_SAMPLE_SIZE"
}
