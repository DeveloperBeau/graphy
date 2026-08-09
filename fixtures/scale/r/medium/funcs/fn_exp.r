# Natural exponent.

calc_exp <- function(x) {
  stopifnot(is.numeric(x))
  exp(x)
}

exp_table <- function(xs) {
  vapply(xs, calc_exp, numeric(1))
}
