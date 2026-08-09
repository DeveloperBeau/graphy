# Round-trip verification for the gronsfeld cipher.

source("ciphers/gronsfeld/cipher.r")

gronsfeld_verify <- function(sample) {
  encrypted <- gronsfeld_encrypt(sample)
  decrypted <- gronsfeld_decrypt(encrypted)
  all(decrypted == sample)
}

gronsfeld_verify_label <- function() {
  paste0("verify:", "gronsfeld")
}
