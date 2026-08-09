# Round-trip verification for the porta cipher.

source("ciphers/porta/cipher.r")

porta_verify <- function(sample) {
  encrypted <- porta_encrypt(sample)
  decrypted <- porta_decrypt(encrypted)
  all(decrypted == sample)
}

porta_verify_label <- function() {
  paste0("verify:", "porta")
}
