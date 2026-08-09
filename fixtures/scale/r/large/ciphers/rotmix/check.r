# Round-trip verification for the rotmix cipher.

source("ciphers/rotmix/cipher.r")

rotmix_verify <- function(sample) {
  encrypted <- rotmix_encrypt(sample)
  decrypted <- rotmix_decrypt(encrypted)
  all(decrypted == sample)
}

rotmix_verify_label <- function() {
  paste0("verify:", "rotmix")
}
