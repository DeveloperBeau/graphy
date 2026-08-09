# Benchmark runner for the revblocks cipher.

source("ciphers/revblocks/cipher.r")
source("ciphers/revblocks/keys.r")

revblocks_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- revblocks_encrypt(sample)
  }
  length(out)
}

revblocks_bench_label <- function(rounds = 16) {
  sprintf("revblocks x%d", rounds)
}
