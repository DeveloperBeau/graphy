# Benchmark runner for the lcgstream cipher.

source("ciphers/lcgstream/cipher.r")
source("ciphers/lcgstream/keys.r")

lcgstream_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- lcgstream_encrypt(sample)
  }
  length(out)
}

lcgstream_bench_label <- function(rounds = 16) {
  sprintf("lcgstream x%d", rounds)
}
