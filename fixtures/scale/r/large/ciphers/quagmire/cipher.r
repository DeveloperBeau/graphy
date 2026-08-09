# Quagmire cipher: repeating key "OCEAN" mixed into the byte stream.

quagmire_key <- "OCEAN"

quagmire_key_stream <- function(n) {
  key <- utf8ToInt(quagmire_key)
  rep(key, length.out = n)
}

quagmire_encrypt <- function(bytes) {
  k <- quagmire_key_stream(length(bytes))
  (bytes + k + 11) %% 256
}

quagmire_decrypt <- function(bytes) {
  k <- quagmire_key_stream(length(bytes))
  (bytes - k - 11) %% 256
}
