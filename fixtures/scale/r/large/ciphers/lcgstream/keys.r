# Key material helpers for the lcgstream cipher.

lcgstream_default_key <- function() {
  42
}

lcgstream_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

lcgstream_key_id <- function() {
  paste0("lcgstream:", lcgstream_default_key())
}
