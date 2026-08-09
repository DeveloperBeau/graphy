# Round-trip verification for the trithemius cipher.

source("ciphers/trithemius/cipher.r")

trithemius_verify <- function(sample) {
  encrypted <- trithemius_encrypt(sample)
  decrypted <- trithemius_decrypt(encrypted)
  all(decrypted == sample)
}

trithemius_verify_label <- function() {
  paste0("verify:", "trithemius")
}
