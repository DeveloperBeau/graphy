# Vigenere cipher: repeating key "LEMON" mixed into the byte stream.

vigenere_key <- "LEMON"

vigenere_key_stream <- function(n) {
  key <- utf8ToInt(vigenere_key)
  rep(key, length.out = n)
}

vigenere_encrypt <- function(bytes) {
  k <- vigenere_key_stream(length(bytes))
  (bytes + k) %% 256
}

vigenere_decrypt <- function(bytes) {
  k <- vigenere_key_stream(length(bytes))
  (bytes - k) %% 256
}
