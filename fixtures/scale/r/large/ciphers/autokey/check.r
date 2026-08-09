# Round-trip verification for the autokey cipher.

source("ciphers/autokey/cipher.r")

autokey_verify <- function(sample) {
  encrypted <- autokey_encrypt(sample)
  decrypted <- autokey_decrypt(encrypted)
  all(decrypted == sample)
}

autokey_verify_label <- function() {
  paste0("verify:", "autokey")
}
