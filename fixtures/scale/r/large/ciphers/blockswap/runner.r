# Benchmark runner for the blockswap cipher.

source("ciphers/blockswap/cipher.r")
source("ciphers/blockswap/keys.r")

blockswap_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- blockswap_encrypt(sample)
  }
  length(out)
}

blockswap_bench_label <- function(rounds = 16) {
  sprintf("blockswap x%d", rounds)
}
