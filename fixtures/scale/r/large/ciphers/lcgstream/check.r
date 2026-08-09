# Round-trip verification for the lcgstream cipher.

source("ciphers/lcgstream/cipher.r")

lcgstream_verify <- function(sample) {
  encrypted <- lcgstream_encrypt(sample)
  decrypted <- lcgstream_decrypt(encrypted)
  all(decrypted == sample)
}

lcgstream_verify_label <- function() {
  paste0("verify:", "lcgstream")
}
