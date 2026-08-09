# Round-trip verification for the rot47 cipher.

source("ciphers/rot47/cipher.r")

rot47_verify <- function(sample) {
  encrypted <- rot47_encrypt(sample)
  decrypted <- rot47_decrypt(encrypted)
  all(decrypted == sample)
}

rot47_verify_label <- function() {
  paste0("verify:", "rot47")
}
