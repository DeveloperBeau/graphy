# Round-trip verification for the quagmire cipher.

source("ciphers/quagmire/cipher.r")

quagmire_verify <- function(sample) {
  encrypted <- quagmire_encrypt(sample)
  decrypted <- quagmire_decrypt(encrypted)
  all(decrypted == sample)
}

quagmire_verify_label <- function() {
  paste0("verify:", "quagmire")
}
