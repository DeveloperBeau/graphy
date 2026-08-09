# Key material helpers for the maskstream cipher.

maskstream_default_key <- function() {
  90
}

maskstream_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

maskstream_key_id <- function() {
  paste0("maskstream:", maskstream_default_key())
}
