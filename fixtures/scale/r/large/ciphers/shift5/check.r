# Round-trip verification for the shift5 cipher.

source("ciphers/shift5/cipher.r")

shift5_verify <- function(sample) {
  encrypted <- shift5_encrypt(sample)
  decrypted <- shift5_decrypt(encrypted)
  all(decrypted == sample)
}

shift5_verify_label <- function() {
  paste0("verify:", "shift5")
}
