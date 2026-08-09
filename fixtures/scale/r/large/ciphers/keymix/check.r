# Round-trip verification for the keymix cipher.

source("ciphers/keymix/cipher.r")

keymix_verify <- function(sample) {
  encrypted <- keymix_encrypt(sample)
  decrypted <- keymix_decrypt(encrypted)
  all(decrypted == sample)
}

keymix_verify_label <- function() {
  paste0("verify:", "keymix")
}
