# Second power.

calc_square <- function(x) {
  stopifnot(is.numeric(x))
  x * x
}

square_table <- function(xs) {
  vapply(xs, calc_square, numeric(1))
}
