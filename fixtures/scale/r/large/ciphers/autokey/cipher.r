# Autokey cipher: repeating key "QUEEN" mixed into the byte stream.

autokey_key <- "QUEEN"

autokey_key_stream <- function(n) {
  key <- utf8ToInt(autokey_key)
  rep(key, length.out = n)
}

autokey_encrypt <- function(bytes) {
  k <- autokey_key_stream(length(bytes))
  (bytes + k) %% 256
}

autokey_decrypt <- function(bytes) {
  k <- autokey_key_stream(length(bytes))
  (bytes - k) %% 256
}
