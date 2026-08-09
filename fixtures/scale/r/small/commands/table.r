# table subcommand: two-column key=value rendering.

source("lib/align.r")
source("lib/log.r")

table_sep <- function() {
  strrep("-", 31)
}

table_row <- function(row) {
  parts <- strsplit(row, "=", fixed = TRUE)[[1]]
  sprintf("%-14s %s", parts[1], paste(parts[-1], collapse = "="))
}

cmd_table <- function(rows) {
  cat(table_sep(), "\n")
  for (row in rows) {
    cat(table_row(row), "\n")
  }
  cat(table_sep(), "\n")
}
