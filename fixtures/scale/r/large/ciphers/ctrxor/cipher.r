# CtrXor cipher: xor against an LCG key stream (a=1, c=1).

ctrxor_keystream <- function(n) {
  state <- 7
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- (state * 1 + 1) %% 256
    ks[i] <- state %% 256
  }
  ks
}

ctrxor_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, ctrxor_keystream(length(bytes)))
}

ctrxor_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  ctrxor_encrypt(bytes)
}
