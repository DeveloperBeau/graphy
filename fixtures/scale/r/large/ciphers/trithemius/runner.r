# Benchmark runner for the trithemius cipher.

source("ciphers/trithemius/cipher.r")
source("ciphers/trithemius/keys.r")

trithemius_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- trithemius_encrypt(sample)
  }
  length(out)
}

trithemius_bench_label <- function(rounds = 16) {
  sprintf("trithemius x%d", rounds)
}
