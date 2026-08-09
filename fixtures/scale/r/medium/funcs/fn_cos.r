# Cosine with optional degree input.

calc_cos <- function(x, degrees = FALSE) {
  if (degrees) {
    x <- x * pi / 180
  }
  cos(x)
}

cos_table <- function(xs) {
  vapply(xs, calc_cos, numeric(1))
}
