# Natural logarithm.

calc_ln <- function(x) {
  stopifnot(is.numeric(x))
  log(x)
}

ln_table <- function(xs) {
  vapply(xs, calc_ln, numeric(1))
}
