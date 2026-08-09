# Key material helpers for the stride cipher.

stride_default_key <- function() {
  9
}

stride_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

stride_key_id <- function() {
  paste0("stride:", stride_default_key())
}
