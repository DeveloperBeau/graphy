# Round-trip verification for the runkey cipher.

source("ciphers/runkey/cipher.r")

runkey_verify <- function(sample) {
  encrypted <- runkey_encrypt(sample)
  decrypted <- runkey_decrypt(encrypted)
  all(decrypted == sample)
}

runkey_verify_label <- function() {
  paste0("verify:", "runkey")
}
