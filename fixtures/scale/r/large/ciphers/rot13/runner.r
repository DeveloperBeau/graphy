# Benchmark runner for the rot13 cipher.

source("ciphers/rot13/cipher.r")
source("ciphers/rot13/keys.r")

rot13_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rot13_encrypt(sample)
  }
  length(out)
}

rot13_bench_label <- function(rounds = 16) {
  sprintf("rot13 x%d", rounds)
}
