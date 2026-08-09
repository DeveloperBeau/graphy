# Benchmark runner for the rc4lite cipher.

source("ciphers/rc4lite/cipher.r")
source("ciphers/rc4lite/keys.r")

rc4lite_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- rc4lite_encrypt(sample)
  }
  length(out)
}

rc4lite_bench_label <- function(rounds = 16) {
  sprintf("rc4lite x%d", rounds)
}
