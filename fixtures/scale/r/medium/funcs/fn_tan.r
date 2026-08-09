# Tangent with optional degree input.

calc_tan <- function(x, degrees = FALSE) {
  if (degrees) {
    x <- x * pi / 180
  }
  tan(x)
}

tan_table <- function(xs) {
  vapply(xs, calc_tan, numeric(1))
}
