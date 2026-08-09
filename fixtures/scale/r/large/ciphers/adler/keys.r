# Key material helpers for the adler cipher.

adler_default_key <- function() {
  0
}

adler_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

adler_key_id <- function() {
  paste0("adler:", adler_default_key())
}
