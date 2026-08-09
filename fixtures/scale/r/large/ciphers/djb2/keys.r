# Key material helpers for the djb2 cipher.

djb2_default_key <- function() {
  5381
}

djb2_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

djb2_key_id <- function() {
  paste0("djb2:", djb2_default_key())
}
