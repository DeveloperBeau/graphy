# LcgStream cipher: xor against an LCG key stream (a=1229, c=17).

lcgstream_keystream <- function(n) {
  state <- 42
  ks <- integer(n)
  for (i in seq_len(n)) {
    state <- (state * 1229 + 17) %% 32749
    ks[i] <- state %% 256
  }
  ks
}

lcgstream_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, lcgstream_keystream(length(bytes)))
}

lcgstream_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  lcgstream_encrypt(bytes)
}
