# Benchmark runner for the xordigest cipher.

source("ciphers/xordigest/cipher.r")
source("ciphers/xordigest/keys.r")

xordigest_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- xordigest_digest(sample)
  }
  length(out)
}

xordigest_bench_label <- function(rounds = 16) {
  sprintf("xordigest x%d", rounds)
}
