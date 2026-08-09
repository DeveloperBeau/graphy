# Benchmark runner for the xorshift cipher.

source("ciphers/xorshift/cipher.r")
source("ciphers/xorshift/keys.r")

xorshift_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- xorshift_encrypt(sample)
  }
  length(out)
}

xorshift_bench_label <- function(rounds = 16) {
  sprintf("xorshift x%d", rounds)
}
