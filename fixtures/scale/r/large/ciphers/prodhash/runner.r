# Benchmark runner for the prodhash cipher.

source("ciphers/prodhash/cipher.r")
source("ciphers/prodhash/keys.r")

prodhash_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- prodhash_digest(sample)
  }
  length(out)
}

prodhash_bench_label <- function(rounds = 16) {
  sprintf("prodhash x%d", rounds)
}
