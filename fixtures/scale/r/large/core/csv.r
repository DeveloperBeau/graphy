# Minimal CSV encoding for the results file.

csv_escape <- function(field) {
  paste0('"', gsub('"', '""', field), '"')
}

csv_row <- function(fields) {
  paste(vapply(fields, csv_escape, character(1)), collapse = ",")
}

csv_header <- function() {
  csv_row(c("cipher", "rounds", "bytes", "micros"))
}
