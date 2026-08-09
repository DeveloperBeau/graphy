# Final one-screen digest after a full run.

summary_row <- function(name, bytes, time) {
  sprintf("%-14s %10s %10s", name, bytes, time)
}

summary_print <- function() {
  cat(sprintf("ciphers run: %d\n", registered_count()))
  cat(summary_row("cipher", "bytes", "time"), "\n")
  cat(summary_row("------", "-----", "----"), "\n")
}
