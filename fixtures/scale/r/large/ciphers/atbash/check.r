# Round-trip verification for the atbash cipher.

source("ciphers/atbash/cipher.r")

atbash_verify <- function(sample) {
  encrypted <- atbash_encrypt(sample)
  decrypted <- atbash_decrypt(encrypted)
  all(decrypted == sample)
}

atbash_verify_label <- function() {
  paste0("verify:", "atbash")
}
