# Key material helpers for the interleave cipher.

interleave_default_key <- function() {
  8
}

interleave_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

interleave_key_id <- function() {
  paste0("interleave:", interleave_default_key())
}
