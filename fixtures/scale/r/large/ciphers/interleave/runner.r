# Benchmark runner for the interleave cipher.

source("ciphers/interleave/cipher.r")
source("ciphers/interleave/keys.r")

interleave_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- interleave_encrypt(sample)
  }
  length(out)
}

interleave_bench_label <- function(rounds = 16) {
  sprintf("interleave x%d", rounds)
}
