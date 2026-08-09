# Benchmark runner for the caesar cipher.

source("ciphers/caesar/cipher.r")
source("ciphers/caesar/keys.r")

caesar_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- caesar_encrypt(sample)
  }
  length(out)
}

caesar_bench_label <- function(rounds = 16) {
  sprintf("caesar x%d", rounds)
}
