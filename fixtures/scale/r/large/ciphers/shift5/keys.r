# Key material helpers for the shift5 cipher.

shift5_default_key <- function() {
  5
}

shift5_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

shift5_key_id <- function() {
  paste0("shift5:", shift5_default_key())
}
