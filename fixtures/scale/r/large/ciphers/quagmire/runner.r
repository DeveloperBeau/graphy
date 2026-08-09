# Benchmark runner for the quagmire cipher.

source("ciphers/quagmire/cipher.r")
source("ciphers/quagmire/keys.r")

quagmire_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- quagmire_encrypt(sample)
  }
  length(out)
}

quagmire_bench_label <- function(rounds = 16) {
  sprintf("quagmire x%d", rounds)
}
