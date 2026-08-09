# Benchmark runner for the xorroll cipher.

source("ciphers/xorroll/cipher.r")
source("ciphers/xorroll/keys.r")

xorroll_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- xorroll_encrypt(sample)
  }
  length(out)
}

xorroll_bench_label <- function(rounds = 16) {
  sprintf("xorroll x%d", rounds)
}
