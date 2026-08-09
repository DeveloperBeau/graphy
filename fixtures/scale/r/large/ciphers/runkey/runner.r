# Benchmark runner for the runkey cipher.

source("ciphers/runkey/cipher.r")
source("ciphers/runkey/keys.r")

runkey_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- runkey_encrypt(sample)
  }
  length(out)
}

runkey_bench_label <- function(rounds = 16) {
  sprintf("runkey x%d", rounds)
}
