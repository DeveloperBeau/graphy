# Benchmark runner for the crclite cipher.

source("ciphers/crclite/cipher.r")
source("ciphers/crclite/keys.r")

crclite_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- crclite_digest(sample)
  }
  length(out)
}

crclite_bench_label <- function(rounds = 16) {
  sprintf("crclite x%d", rounds)
}
