# Benchmark runner for the gronsfeld cipher.

source("ciphers/gronsfeld/cipher.r")
source("ciphers/gronsfeld/keys.r")

gronsfeld_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- gronsfeld_encrypt(sample)
  }
  length(out)
}

gronsfeld_bench_label <- function(rounds = 16) {
  sprintf("gronsfeld x%d", rounds)
}
