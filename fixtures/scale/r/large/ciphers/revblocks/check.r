# Round-trip verification for the revblocks cipher.

source("ciphers/revblocks/cipher.r")

revblocks_verify <- function(sample) {
  encrypted <- revblocks_encrypt(sample)
  decrypted <- revblocks_decrypt(encrypted)
  all(decrypted == sample)
}

revblocks_verify_label <- function() {
  paste0("verify:", "revblocks")
}
