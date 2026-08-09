# Third power.

calc_cube <- function(x) {
  stopifnot(is.numeric(x))
  x * x * x
}

cube_table <- function(xs) {
  vapply(xs, calc_cube, numeric(1))
}
