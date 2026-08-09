# XorRoll cipher: xor against an LCG key stream (a=75, c=74).

xorroll_keystream <- function(n) {
  state <- 193
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- (state * 75 + 74) %% 65537
    ks[i] <- state %% 256
  }
  ks
}

xorroll_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, xorroll_keystream(length(bytes)))
}

xorroll_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  xorroll_encrypt(bytes)
}
