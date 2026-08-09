# Benchmark runner for the djb2 cipher.

source("ciphers/djb2/cipher.r")
source("ciphers/djb2/keys.r")

djb2_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- djb2_digest(sample)
  }
  length(out)
}

djb2_bench_label <- function(rounds = 16) {
  sprintf("djb2 x%d", rounds)
}
