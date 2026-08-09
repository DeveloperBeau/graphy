# Gronsfeld cipher: repeating key "31415" mixed into the byte stream.

gronsfeld_key <- "31415"

gronsfeld_key_stream <- function(n) {
  key <- utf8ToInt(gronsfeld_key)
  rep(key, length.out = n)
}

gronsfeld_encrypt <- function(bytes) {
  k <- gronsfeld_key_stream(length(bytes))
  (bytes + k) %% 256
}

gronsfeld_decrypt <- function(bytes) {
  k <- gronsfeld_key_stream(length(bytes))
  (bytes - k) %% 256
}
