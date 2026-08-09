# Drop the fractional part.

calc_trunc <- function(x) {
  stopifnot(is.numeric(x))
  trunc(x)
}

trunc_table <- function(xs) {
  vapply(xs, calc_trunc, numeric(1))
}
