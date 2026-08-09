# In-memory expression history.

.calc_history <- new.env()
.calc_history$entries <- character(0)

history_add <- function(expr, result) {
  .calc_history$entries <- c(.calc_history$entries, sprintf("%s = %g", expr, result))
}

history_show <- function() {
  for (entry in .calc_history$entries) {
    cat(entry, "\n")
  }
}

history_clear <- function() {
  .calc_history$entries <- character(0)
}
