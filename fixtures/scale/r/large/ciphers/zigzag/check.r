# Round-trip verification for the zigzag cipher.

source("ciphers/zigzag/cipher.r")

zigzag_verify <- function(sample) {
  encrypted <- zigzag_encrypt(sample)
  decrypted <- zigzag_decrypt(encrypted)
  all(decrypted == sample)
}

zigzag_verify_label <- function() {
  paste0("verify:", "zigzag")
}
