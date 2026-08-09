# Benchmark runner for the affine cipher.

source("ciphers/affine/cipher.r")
source("ciphers/affine/keys.r")

affine_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- affine_encrypt(sample)
  }
  length(out)
}

affine_bench_label <- function(rounds = 16) {
  sprintf("affine x%d", rounds)
}
