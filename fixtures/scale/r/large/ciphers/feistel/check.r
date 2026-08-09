# Round-trip verification for the feistel cipher.

source("ciphers/feistel/cipher.r")

feistel_verify <- function(sample) {
  encrypted <- feistel_encrypt(sample)
  decrypted <- feistel_decrypt(encrypted)
  all(decrypted == sample)
}

feistel_verify_label <- function() {
  paste0("verify:", "feistel")
}
