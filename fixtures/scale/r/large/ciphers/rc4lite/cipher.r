# Rc4Lite cipher: xor against an LCG key stream (a=181, c=359).

rc4lite_keystream <- function(n) {
  state <- 17
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- (state * 181 + 359) %% 65521
    ks[i] <- state %% 256
  }
  ks
}

rc4lite_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, rc4lite_keystream(length(bytes)))
}

rc4lite_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  rc4lite_encrypt(bytes)
}
