# Benchmark runner for the autokey cipher.

source("ciphers/autokey/cipher.r")
source("ciphers/autokey/keys.r")

autokey_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- autokey_encrypt(sample)
  }
  length(out)
}

autokey_bench_label <- function(rounds = 16) {
  sprintf("autokey x%d", rounds)
}
