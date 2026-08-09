# Inverse cosine.

calc_acos <- function(x) {
  stopifnot(is.numeric(x))
  acos(x)
}

acos_table <- function(xs) {
  vapply(xs, calc_acos, numeric(1))
}
