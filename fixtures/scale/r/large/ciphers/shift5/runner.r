# Benchmark runner for the shift5 cipher.

source("ciphers/shift5/cipher.r")
source("ciphers/shift5/keys.r")

shift5_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- shift5_encrypt(sample)
  }
  length(out)
}

shift5_bench_label <- function(rounds = 16) {
  sprintf("shift5 x%d", rounds)
}
