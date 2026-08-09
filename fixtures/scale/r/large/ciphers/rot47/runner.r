# Benchmark runner for the rot47 cipher.

source("ciphers/rot47/cipher.r")
source("ciphers/rot47/keys.r")

rot47_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rot47_encrypt(sample)
  }
  length(out)
}

rot47_bench_label <- function(rounds = 16) {
  sprintf("rot47 x%d", rounds)
}
