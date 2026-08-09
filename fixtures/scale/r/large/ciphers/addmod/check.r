# Round-trip verification for the addmod cipher.

source("ciphers/addmod/cipher.r")

addmod_verify <- function(sample) {
  encrypted <- addmod_encrypt(sample)
  decrypted <- addmod_decrypt(encrypted)
  all(decrypted == sample)
}

addmod_verify_label <- function() {
  paste0("verify:", "addmod")
}
