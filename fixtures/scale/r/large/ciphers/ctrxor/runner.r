# Benchmark runner for the ctrxor cipher.

source("ciphers/ctrxor/cipher.r")
source("ciphers/ctrxor/keys.r")

ctrxor_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- ctrxor_encrypt(sample)
  }
  length(out)
}

ctrxor_bench_label <- function(rounds = 16) {
  sprintf("ctrxor x%d", rounds)
}
