# Append-only results file under the working directory.

results_path <- function() {
  path <- Sys.getenv("CIPHBENCH_RESULTS", unset = "")
  if (nzchar(path)) path else "results.csv"
}

store_init <- function() {
  writeLines(character(0), results_path())
}

store_append <- function(row) {
  cat(row, "\n", file = results_path(), append = TRUE, sep = "")
}
