# Inverse sine.

calc_asin <- function(x) {
  stopifnot(is.numeric(x))
  asin(x)
}

asin_table <- function(xs) {
  vapply(xs, calc_asin, numeric(1))
}
