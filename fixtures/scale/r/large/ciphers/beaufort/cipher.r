# Beaufort cipher: repeating key "FORTRESS" mixed into the byte stream.

beaufort_key <- "FORTRESS"

beaufort_key_stream <- function(n) {
  key <- utf8ToInt(beaufort_key)
  rep(key, length.out = n)
}

beaufort_encrypt <- function(bytes) {
  k <- beaufort_key_stream(length(bytes))
  (k - bytes) %% 256
}

beaufort_decrypt <- function(bytes) {
  # Subtraction against the key stream is its own inverse.
  beaufort_encrypt(bytes)
}
