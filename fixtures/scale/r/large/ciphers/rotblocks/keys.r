# Key material helpers for the rotblocks cipher.

rotblocks_default_key <- function() {
  6
}

rotblocks_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rotblocks_key_id <- function() {
  paste0("rotblocks:", rotblocks_default_key())
}
