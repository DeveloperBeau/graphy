# Feistel cipher: xor against an LCG key stream (a=37, c=11).

feistel_keystream <- function(n) {
  state <- 101
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- (state * 37 + 11) %% 256
    ks[i] <- state %% 256
  }
  ks
}

feistel_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, feistel_keystream(length(bytes)))
}

feistel_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  feistel_encrypt(bytes)
}
