# Benchmark runner for the railfence cipher.

source("ciphers/railfence/cipher.r")
source("ciphers/railfence/keys.r")

railfence_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- railfence_encrypt(sample)
  }
  length(out)
}

railfence_bench_label <- function(rounds = 16) {
  sprintf("railfence x%d", rounds)
}
