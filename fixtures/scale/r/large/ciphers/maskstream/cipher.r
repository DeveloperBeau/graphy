# MaskStream cipher: xor against a fixed 4-byte mask.

maskstream_mask <- c(23, 105, 187, 7)

maskstream_keystream <- function(n) {
  rep(maskstream_mask, length.out = n)
}

maskstream_encrypt <- function(bytes) {
  mapply(bitwXor, bytes, maskstream_keystream(length(bytes)))
}

maskstream_decrypt <- function(bytes) {
  # Xor stream ciphers are symmetric.
  maskstream_encrypt(bytes)
}
