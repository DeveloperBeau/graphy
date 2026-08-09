# Round-trip verification for the rc4lite cipher.

source("ciphers/rc4lite/cipher.r")

rc4lite_verify <- function(sample) {
  encrypted <- rc4lite_encrypt(sample)
  decrypted <- rc4lite_decrypt(encrypted)
  all(decrypted == sample)
}

rc4lite_verify_label <- function() {
  paste0("verify:", "rc4lite")
}
