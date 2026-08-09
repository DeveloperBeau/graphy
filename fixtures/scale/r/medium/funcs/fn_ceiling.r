# Round toward positive infinity.

calc_ceiling <- function(x) {
  stopifnot(is.numeric(x))
  ceiling(x)
}

ceiling_table <- function(xs) {
  vapply(xs, calc_ceiling, numeric(1))
}
