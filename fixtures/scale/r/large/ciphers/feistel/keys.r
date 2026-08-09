# Key material helpers for the feistel cipher.

feistel_default_key <- function() {
  101
}

feistel_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

feistel_key_id <- function() {
  paste0("feistel:", feistel_default_key())
}
