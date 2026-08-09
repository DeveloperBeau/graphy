# Round-trip verification for the ctrxor cipher.

source("ciphers/ctrxor/cipher.r")

ctrxor_verify <- function(sample) {
  encrypted <- ctrxor_encrypt(sample)
  decrypted <- ctrxor_decrypt(encrypted)
  all(decrypted == sample)
}

ctrxor_verify_label <- function() {
  paste0("verify:", "ctrxor")
}
