# Round-trip verification for the railfence cipher.

source("ciphers/railfence/cipher.r")

railfence_verify <- function(sample) {
  encrypted <- railfence_encrypt(sample)
  decrypted <- railfence_decrypt(encrypted)
  all(decrypted == sample)
}

railfence_verify_label <- function() {
  paste0("verify:", "railfence")
}
