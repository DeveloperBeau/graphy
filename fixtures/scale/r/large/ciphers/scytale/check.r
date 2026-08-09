# Round-trip verification for the scytale cipher.

source("ciphers/scytale/cipher.r")

scytale_verify <- function(sample) {
  encrypted <- scytale_encrypt(sample)
  decrypted <- scytale_decrypt(encrypted)
  all(decrypted == sample)
}

scytale_verify_label <- function() {
  paste0("verify:", "scytale")
}
