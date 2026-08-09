# Benchmark runner for the fnv1a cipher.

source("ciphers/fnv1a/cipher.r")
source("ciphers/fnv1a/keys.r")

fnv1a_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- fnv1a_digest(sample)
  }
  length(out)
}

fnv1a_bench_label <- function(rounds = 16) {
  sprintf("fnv1a x%d", rounds)
}
