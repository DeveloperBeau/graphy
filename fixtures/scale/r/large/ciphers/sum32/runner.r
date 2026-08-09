# Benchmark runner for the sum32 cipher.

source("ciphers/sum32/cipher.r")
source("ciphers/sum32/keys.r")

sum32_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- sum32_digest(sample)
  }
  length(out)
}

sum32_bench_label <- function(rounds = 16) {
  sprintf("sum32 x%d", rounds)
}
