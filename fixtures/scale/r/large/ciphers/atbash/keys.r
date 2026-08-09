# Key material helpers for the atbash cipher.

atbash_default_key <- function() {
  3
}

atbash_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

atbash_key_id <- function() {
  paste0("atbash:", atbash_default_key())
}
