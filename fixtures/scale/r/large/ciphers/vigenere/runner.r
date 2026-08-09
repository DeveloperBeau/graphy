# Benchmark runner for the vigenere cipher.

source("ciphers/vigenere/cipher.r")
source("ciphers/vigenere/keys.r")

vigenere_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- vigenere_encrypt(sample)
  }
  length(out)
}

vigenere_bench_label <- function(rounds = 16) {
  sprintf("vigenere x%d", rounds)
}
