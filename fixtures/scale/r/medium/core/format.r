# Result formatting helpers.

fmt_number <- function(value) {
  precision <- config_get("precision")
  formatC(value, digits = precision, format = "g")
}

fmt_result <- function(value) {
  paste0("= ", fmt_number(value))
}

fmt_hex <- function(value) {
  sprintf("0x%x", as.integer(value))
}
