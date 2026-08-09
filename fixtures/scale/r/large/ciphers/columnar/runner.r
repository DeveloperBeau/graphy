# Benchmark runner for the columnar cipher.

source("ciphers/columnar/cipher.r")
source("ciphers/columnar/keys.r")

columnar_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- columnar_encrypt(sample)
  }
  length(out)
}

columnar_bench_label <- function(rounds = 16) {
  sprintf("columnar x%d", rounds)
}
