# Error slot shared by parser and evaluator.

.calc_error <- new.env()
.calc_error$message <- ""

err_set <- function(message) {
  .calc_error$message <- message
}

err_get <- function() {
  .calc_error$message
}

err_clear <- function() {
  .calc_error$message <- ""
}
