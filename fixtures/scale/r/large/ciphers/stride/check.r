# Round-trip verification for the stride cipher.

source("ciphers/stride/cipher.r")

stride_verify <- function(sample) {
  encrypted <- stride_encrypt(sample)
  decrypted <- stride_decrypt(encrypted)
  all(decrypted == sample)
}

stride_verify_label <- function() {
  paste0("verify:", "stride")
}
