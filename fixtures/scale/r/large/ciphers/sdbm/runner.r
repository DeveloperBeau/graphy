# Benchmark runner for the sdbm cipher.

source("ciphers/sdbm/cipher.r")
source("ciphers/sdbm/keys.r")

sdbm_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- sdbm_digest(sample)
  }
  length(out)
}

sdbm_bench_label <- function(rounds = 16) {
  sprintf("sdbm x%d", rounds)
}
