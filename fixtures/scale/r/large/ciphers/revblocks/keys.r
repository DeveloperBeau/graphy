# Key material helpers for the revblocks cipher.

revblocks_default_key <- function() {
  4
}

revblocks_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

revblocks_key_id <- function() {
  paste0("revblocks:", revblocks_default_key())
}
