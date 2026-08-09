# Benchmark runner for the rothash cipher.

source("ciphers/rothash/cipher.r")
source("ciphers/rothash/keys.r")

rothash_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rothash_digest(sample)
  }
  length(out)
}

rothash_bench_label <- function(rounds = 16) {
  sprintf("rothash x%d", rounds)
}
