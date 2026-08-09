# Benchmark runner for the stride cipher.

source("ciphers/stride/cipher.r")
source("ciphers/stride/keys.r")

stride_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- stride_encrypt(sample)
  }
  length(out)
}

stride_bench_label <- function(rounds = 16) {
  sprintf("stride x%d", rounds)
}
