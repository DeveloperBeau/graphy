# Key material helpers for the affine cipher.

affine_default_key <- function() {
  8
}

affine_validate_key <- function(key) {
  is.numeric(key) && length(key) == 1 && key >= 0
}

affine_key_id <- function() {
  paste0("affine:", affine_default_key())
}
