# Key material helpers for the trithemius cipher.

trithemius_default_key <- function() {
  "ABC"
}

trithemius_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

trithemius_key_id <- function() {
  paste0("trithemius:", trithemius_default_key())
}
