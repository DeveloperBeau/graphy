# Benchmark runner for the decimation cipher.

source("ciphers/decimation/cipher.r")
source("ciphers/decimation/keys.r")

decimation_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- decimation_encrypt(sample)
  }
  length(out)
}

decimation_bench_label <- function(rounds = 16) {
  sprintf("decimation x%d", rounds)
}
