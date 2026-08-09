# Benchmark runner for the porta cipher.

source("ciphers/porta/cipher.r")
source("ciphers/porta/keys.r")

porta_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- porta_encrypt(sample)
  }
  length(out)
}

porta_bench_label <- function(rounds = 16) {
  sprintf("porta x%d", rounds)
}
