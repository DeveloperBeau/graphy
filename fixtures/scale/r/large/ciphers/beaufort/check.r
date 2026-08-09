# Round-trip verification for the beaufort cipher.

source("ciphers/beaufort/cipher.r")

beaufort_verify <- function(sample) {
  encrypted <- beaufort_encrypt(sample)
  decrypted <- beaufort_decrypt(encrypted)
  all(decrypted == sample)
}

beaufort_verify_label <- function() {
  paste0("verify:", "beaufort")
}
