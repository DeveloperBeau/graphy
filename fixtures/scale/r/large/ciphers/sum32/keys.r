# Key material helpers for the sum32 cipher.

sum32_default_key <- function() {
  0
}

sum32_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

sum32_key_id <- function() {
  paste0("sum32:", sum32_default_key())
}
