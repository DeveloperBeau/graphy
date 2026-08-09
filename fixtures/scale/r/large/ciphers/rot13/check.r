# Round-trip verification for the rot13 cipher.

source("ciphers/rot13/cipher.r")

rot13_verify <- function(sample) {
  encrypted <- rot13_encrypt(sample)
  decrypted <- rot13_decrypt(encrypted)
  all(decrypted == sample)
}

rot13_verify_label <- function() {
  paste0("verify:", "rot13")
}
