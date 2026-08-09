# Post-run report over the stored results.

report_line <- function(row) {
  paste0("  ", gsub('","', "  ", row, fixed = TRUE))
}

report_summary <- function() {
  path <- results_path()
  if (!file.exists(path)) {
    log_warn("no results at", path)
    return(invisible(NULL))
  }
  cat(sprintf("results from %s:\n", path))
  for (row in readLines(path)) {
    cat(report_line(row), "\n")
  }
}
