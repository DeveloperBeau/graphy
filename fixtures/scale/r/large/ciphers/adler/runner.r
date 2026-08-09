# Benchmark runner for the adler cipher.

source("ciphers/adler/cipher.r")
source("ciphers/adler/keys.r")

adler_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- adler_digest(sample)
  }
  length(out)
}

adler_bench_label <- function(rounds = 16) {
  sprintf("adler x%d", rounds)
}
