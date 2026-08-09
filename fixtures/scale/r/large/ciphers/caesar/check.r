# Round-trip verification for the caesar cipher.

source("ciphers/caesar/cipher.r")

caesar_verify <- function(sample) {
  encrypted <- caesar_encrypt(sample)
  decrypted <- caesar_decrypt(encrypted)
  all(decrypted == sample)
}

caesar_verify_label <- function() {
  paste0("verify:", "caesar")
}
