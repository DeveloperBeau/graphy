# Round-trip verification for the vigenere cipher.

source("ciphers/vigenere/cipher.r")

vigenere_verify <- function(sample) {
  encrypted <- vigenere_encrypt(sample)
  decrypted <- vigenere_decrypt(encrypted)
  all(decrypted == sample)
}

vigenere_verify_label <- function() {
  paste0("verify:", "vigenere")
}
