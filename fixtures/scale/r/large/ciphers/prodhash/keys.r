# Key material helpers for the prodhash cipher.

prodhash_default_key <- function() {
  7
}

prodhash_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

prodhash_key_id <- function() {
  paste0("prodhash:", prodhash_default_key())
}
