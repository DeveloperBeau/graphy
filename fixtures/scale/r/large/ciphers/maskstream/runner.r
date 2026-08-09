# Benchmark runner for the maskstream cipher.

source("ciphers/maskstream/cipher.r")
source("ciphers/maskstream/keys.r")

maskstream_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- maskstream_encrypt(sample)
  }
  length(out)
}

maskstream_bench_label <- function(rounds = 16) {
  sprintf("maskstream x%d", rounds)
}
