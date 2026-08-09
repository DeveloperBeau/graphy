# Benchmark runner for the xorbasic cipher.

source("ciphers/xorbasic/cipher.r")
source("ciphers/xorbasic/keys.r")

xorbasic_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- xorbasic_encrypt(sample)
  }
  length(out)
}

xorbasic_bench_label <- function(rounds = 16) {
  sprintf("xorbasic x%d", rounds)
}
