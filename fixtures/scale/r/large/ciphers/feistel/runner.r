# Benchmark runner for the feistel cipher.

source("ciphers/feistel/cipher.r")
source("ciphers/feistel/keys.r")

feistel_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- feistel_encrypt(sample)
  }
  length(out)
}

feistel_bench_label <- function(rounds = 16) {
  sprintf("feistel x%d", rounds)
}
