# Benchmark runner for the zigzag cipher.

source("ciphers/zigzag/cipher.r")
source("ciphers/zigzag/keys.r")

zigzag_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- zigzag_encrypt(sample)
  }
  length(out)
}

zigzag_bench_label <- function(rounds = 16) {
  sprintf("zigzag x%d", rounds)
}
