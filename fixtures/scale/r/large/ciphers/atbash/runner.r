# Benchmark runner for the atbash cipher.

source("ciphers/atbash/cipher.r")
source("ciphers/atbash/keys.r")

atbash_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- atbash_encrypt(sample)
  }
  length(out)
}

atbash_bench_label <- function(rounds = 16) {
  sprintf("atbash x%d", rounds)
}
