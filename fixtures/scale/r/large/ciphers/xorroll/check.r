# Round-trip verification for the xorroll cipher.

source("ciphers/xorroll/cipher.r")

xorroll_verify <- function(sample) {
  encrypted <- xorroll_encrypt(sample)
  decrypted <- xorroll_decrypt(encrypted)
  all(decrypted == sample)
}

xorroll_verify_label <- function() {
  paste0("verify:", "xorroll")
}
