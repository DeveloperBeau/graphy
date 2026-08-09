# Key material helpers for the keymix cipher.

keymix_default_key <- function() {
  "ZEBRA"
}

keymix_validate_key <- function(key) {
  is.character(key) && nchar(key) >= 3
}

keymix_key_id <- function() {
  paste0("keymix:", keymix_default_key())
}
