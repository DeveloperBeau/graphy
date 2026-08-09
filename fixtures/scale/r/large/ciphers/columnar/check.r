# Round-trip verification for the columnar cipher.

source("ciphers/columnar/cipher.r")

columnar_verify <- function(sample) {
  encrypted <- columnar_encrypt(sample)
  decrypted <- columnar_decrypt(encrypted)
  all(decrypted == sample)
}

columnar_verify_label <- function() {
  paste0("verify:", "columnar")
}
