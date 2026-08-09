# XorBasic cipher: xor against a fixed 1-byte mask.

xorbasic_mask <- c(90)

xorbasic_keystream <- function(n) {
  rep(xorbasic_mask, length.out = n)
}

xorbasic_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, xorbasic_keystream(length(bytes)))
}

xorbasic_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  xorbasic_encrypt(bytes)
}
