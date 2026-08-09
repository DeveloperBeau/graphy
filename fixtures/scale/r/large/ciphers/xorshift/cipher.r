# XorShift cipher: xor against a 16-bit xorshift key stream.

xorshift_keystream <- function(n) {
  state <- 911
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- bitwAnd(bitwXor(state, bitwShiftL(state, 3)), 65535)
    state <- bitwAnd(bitwXor(state, bitwShiftR(state, 5)), 65535)
    ks[i] <- state %% 256
  }
  ks
}

xorshift_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, xorshift_keystream(length(bytes)))
}

xorshift_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  xorshift_encrypt(bytes)
}
