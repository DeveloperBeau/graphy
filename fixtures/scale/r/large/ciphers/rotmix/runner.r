# Benchmark runner for the rotmix cipher.

source("ciphers/rotmix/cipher.r")
source("ciphers/rotmix/keys.r")

rotmix_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rotmix_encrypt(sample)
  }
  length(out)
}

rotmix_bench_label <- function(rounds = 16) {
  sprintf("rotmix x%d", rounds)
}
