# Full-run orchestration over every registered cipher.

bench_one() {
  local name="$1" sample="$2" start len us
  start=$(timer_now)
  len=$("${name}_run_bench" "$sample" "$BENCH_ROUNDS")
  us=$(timer_elapsed "$start")
  store_append "$(csv_row "$name" "$BENCH_ROUNDS" "$len" "$us")"
  progress_tick "$name"
}

bench_all() {
  local sample name
  parse_args "$@"
  sample=$(corpus_sample "$BENCH_SAMPLE_SIZE")
  store_init
  store_append "$(csv_header)"
  progress_start "$(registered_count)"
  for name in "${CIPHER_NAMES[@]}"; do
    bench_one "$name" "$sample"
  done
  progress_done
  summary_print
}

verify_all() {
  local sample name
  sample=$(corpus_sample 64)
  for name in "${CIPHER_NAMES[@]}"; do
    "${name}_verify" "$sample" || log_error "verify failed: $name"
  done
}
