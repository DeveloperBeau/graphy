# Round-trip verification for the affine cipher.

source("ciphers/affine/cipher.r")

affine_verify <- function(sample) {
  encrypted <- affine_encrypt(sample)
  decrypted <- affine_decrypt(encrypted)
  all(decrypted == sample)
}

affine_verify_label <- function() {
  paste0("verify:", "affine")
}
