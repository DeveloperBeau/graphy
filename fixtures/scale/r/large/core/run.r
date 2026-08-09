# Full-run orchestration over every registered cipher.

bench_one <- function(name, sample) {
  runner <- get(paste0(name, "_run_bench"))
  start <- timer_start()
  len <- runner(sample, option_get("rounds"))
  micros <- timer_elapsed_micros(start)
  store_append(csv_row(c(name, option_get("rounds"), len, micros)))
  progress_tick(name)
}

bench_all <- function() {
  sample <- corpus_sample(option_get("sample_size"))
  store_init()
  store_append(csv_header())
  progress_start(registered_count())
  for (name in registered_ciphers()) {
    bench_one(name, sample)
  }
  progress_done()
  summary_print()
}

verify_all <- function() {
  sample <- corpus_sample(64)
  for (name in registered_ciphers()) {
    checker <- get(paste0(name, "_verify"))
    if (!checker(sample)) {
      log_warn("verify failed:", name)
    }
  }
}
