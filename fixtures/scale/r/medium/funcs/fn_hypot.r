# Euclidean distance from the origin.

calc_hypot <- function(x, y) {
  stopifnot(is.numeric(x), is.numeric(y))
  sqrt(x * x + y * y)
}

hypot_table <- function(xs, ys) {
  mapply(calc_hypot, xs, ys)
}
