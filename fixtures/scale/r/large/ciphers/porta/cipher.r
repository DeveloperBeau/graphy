# Porta cipher: repeating key "GLACIER" mixed into the byte stream.

porta_key <- "GLACIER"

porta_key_stream <- function(n) {
  key <- utf8ToInt(porta_key)
  rep(key, length.out = n)
}

porta_encrypt <- function(bytes) {
  k <- porta_key_stream(length(bytes))
  (k - bytes) %% 256
}

porta_decrypt <- function(bytes) {
  # Subtraction against the key stream is its own inverse.
  porta_encrypt(bytes)
}
