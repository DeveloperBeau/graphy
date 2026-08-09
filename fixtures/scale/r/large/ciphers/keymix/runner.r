# Benchmark runner for the keymix cipher.

source("ciphers/keymix/cipher.r")
source("ciphers/keymix/keys.r")

keymix_run_bench <- function(sample, rounds = 16) {
  out <- sample
  for (r in seq_len(rounds)) {
    out <- keymix_encrypt(sample)
  }
  length(out)
}

keymix_bench_label <- function(rounds = 16) {
  sprintf("keymix x%d", rounds)
}
