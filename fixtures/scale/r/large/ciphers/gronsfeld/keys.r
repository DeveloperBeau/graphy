# Key material helpers for the gronsfeld cipher.

gronsfeld_default_key <- function() {
  "31415"
}

gronsfeld_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

gronsfeld_key_id <- function() {
  paste0("gronsfeld:", gronsfeld_default_key())
}
