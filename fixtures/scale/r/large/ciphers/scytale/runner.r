# Benchmark runner for the scytale cipher.

source("ciphers/scytale/cipher.r")
source("ciphers/scytale/keys.r")

scytale_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- scytale_encrypt(sample)
  }
  length(out)
}

scytale_bench_label <- function(rounds = 16) {
  sprintf("scytale x%d", rounds)
}
