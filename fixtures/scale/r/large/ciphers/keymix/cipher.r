# Keymix cipher: repeating key "ZEBRA" mixed into the byte stream.

keymix_key <- "ZEBRA"

keymix_key_stream <- function(n) {
  key <- utf8ToInt(keymix_key)
  rep(key, length.out = n)
}

keymix_encrypt <- function(bytes) {
  k <- keymix_key_stream(length(bytes))
  (bytes + k + 7) %% 256
}

keymix_decrypt <- function(bytes) {
  k <- keymix_key_stream(length(bytes))
  (bytes - k - 7) %% 256
}
