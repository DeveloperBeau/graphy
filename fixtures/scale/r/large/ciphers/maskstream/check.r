# Round-trip verification for the maskstream cipher.

source("ciphers/maskstream/cipher.r")

maskstream_verify <- function(sample) {
  encrypted <- maskstream_encrypt(sample)
  decrypted <- maskstream_decrypt(encrypted)
  all(decrypted == sample)
}

maskstream_verify_label <- function() {
  paste0("verify:", "maskstream")
}
