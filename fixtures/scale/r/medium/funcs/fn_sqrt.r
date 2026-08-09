# Square root.

calc_sqrt <- function(x) {
  stopifnot(is.numeric(x))
  sqrt(x)
}

sqrt_table <- function(xs) {
  vapply(xs, calc_sqrt, numeric(1))
}
