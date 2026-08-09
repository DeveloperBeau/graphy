# Trithemius cipher: repeating key "ABC" mixed into the byte stream.

trithemius_key <- "ABC"

trithemius_key_stream <- function(n) {
  key <- utf8ToInt(trithemius_key)
  rep(key, length.out = n)
}

trithemius_encrypt <- function(bytes) {
  k <- trithemius_key_stream(length(bytes))
  (bytes + k + seq_along(bytes) - 1) %% 256
}

trithemius_decrypt <- function(bytes) {
  k <- trithemius_key_stream(length(bytes))
  (bytes - k - (seq_along(bytes) - 1)) %% 256
}
