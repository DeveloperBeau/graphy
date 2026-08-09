# Benchmark runner for the cbcxor cipher.

source("ciphers/cbcxor/cipher.r")
source("ciphers/cbcxor/keys.r")

cbcxor_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- cbcxor_encrypt(sample)
  }
  length(out)
}

cbcxor_bench_label <- function(rounds = 16) {
  sprintf("cbcxor x%d", rounds)
}
