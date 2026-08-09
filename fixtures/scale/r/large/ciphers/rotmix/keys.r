# Key material helpers for the rotmix cipher.

rotmix_default_key <- function() {
  3
}

rotmix_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

rotmix_key_id <- function() {
  paste0("rotmix:", rotmix_default_key())
}
