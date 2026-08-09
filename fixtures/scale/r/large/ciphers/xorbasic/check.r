# Round-trip verification for the xorbasic cipher.

source("ciphers/xorbasic/cipher.r")

xorbasic_verify <- function(sample) {
  encrypted <- xorbasic_encrypt(sample)
  decrypted <- xorbasic_decrypt(encrypted)
  all(decrypted == sample)
}

xorbasic_verify_label <- function() {
  paste0("verify:", "xorbasic")
}
