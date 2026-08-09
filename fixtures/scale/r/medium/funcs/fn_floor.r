# Round toward negative infinity.

calc_floor <- function(x) {
  stopifnot(is.numeric(x))
  floor(x)
}

floor_table <- function(xs) {
  vapply(xs, calc_floor, numeric(1))
}
