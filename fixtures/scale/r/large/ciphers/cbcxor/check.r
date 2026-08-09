# Round-trip verification for the cbcxor cipher.

source("ciphers/cbcxor/cipher.r")

cbcxor_verify <- function(sample) {
  encrypted <- cbcxor_encrypt(sample)
  decrypted <- cbcxor_decrypt(encrypted)
  all(decrypted == sample)
}

cbcxor_verify_label <- function() {
  paste0("verify:", "cbcxor")
}
