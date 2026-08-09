# Runkey cipher: repeating key "THEQUICKBROWNFOX" mixed into the byte stream.

runkey_key <- "THEQUICKBROWNFOX"

runkey_key_stream <- function(n) {
  key <- utf8ToInt(runkey_key)
  rep(key, length.out = n)
}

runkey_encrypt <- function(bytes) {
  k <- runkey_key_stream(length(bytes))
  (bytes + k) %% 256
}

runkey_decrypt <- function(bytes) {
  k <- runkey_key_stream(length(bytes))
  (bytes - k) %% 256
}
