# Named mathematical constants.

calc_constants <- c(pi = pi, e = exp(1), tau = 2 * pi)

constant_get <- function(name) {
  if (!(name %in% names(calc_constants))) {
    stop(sprintf("unknown constant %s", name))
  }
  calc_constants[[name]]
}

constant_names <- function() {
  names(calc_constants)
}
