# Round-trip verification for the xorshift cipher.

source("ciphers/xorshift/cipher.r")

xorshift_verify <- function(sample) {
  encrypted <- xorshift_encrypt(sample)
  decrypted <- xorshift_decrypt(encrypted)
  all(decrypted == sample)
}

xorshift_verify_label <- function() {
  paste0("verify:", "xorshift")
}
