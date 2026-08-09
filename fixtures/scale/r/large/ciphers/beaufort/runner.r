# Benchmark runner for the beaufort cipher.

source("ciphers/beaufort/cipher.r")
source("ciphers/beaufort/keys.r")

beaufort_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- beaufort_encrypt(sample)
  }
  length(out)
}

beaufort_bench_label <- function(rounds = 16) {
  sprintf("beaufort x%d", rounds)
}
