# Benchmark runner for the rotblocks cipher.

source("ciphers/rotblocks/cipher.r")
source("ciphers/rotblocks/keys.r")

rotblocks_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rotblocks_encrypt(sample)
  }
  length(out)
}

rotblocks_bench_label <- function(rounds = 16) {
  sprintf("rotblocks x%d", rounds)
}
