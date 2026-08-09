# Registry of callable library functions.

.calc_registry <- new.env()
.calc_registry$names <- character(0)

registry_add <- function(name) {
  .calc_registry$names <- c(.calc_registry$names, name)
}

registry_contains <- function(name) {
  name %in% .calc_registry$names
}

registry_size <- function() {
  length(.calc_registry$names)
}
