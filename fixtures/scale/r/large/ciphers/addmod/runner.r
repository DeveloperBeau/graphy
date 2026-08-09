# Benchmark runner for the addmod cipher.

source("ciphers/addmod/cipher.r")
source("ciphers/addmod/keys.r")

addmod_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- addmod_encrypt(sample)
  }
  length(out)
}

addmod_bench_label <- function(rounds = 16) {
  sprintf("addmod x%d", rounds)
}
