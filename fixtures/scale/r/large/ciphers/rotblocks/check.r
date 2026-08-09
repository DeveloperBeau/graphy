# Round-trip verification for the rotblocks cipher.

source("ciphers/rotblocks/cipher.r")

rotblocks_verify <- function(sample) {
  encrypted <- rotblocks_encrypt(sample)
  decrypted <- rotblocks_decrypt(encrypted)
  all(decrypted == sample)
}

rotblocks_verify_label <- function() {
  paste0("verify:", "rotblocks")
}
