# Microsecond wall-clock timing.

timer_start <- function() {
  proc.time()[["elapsed"]]
}

timer_elapsed_micros <- function(start) {
  as.integer((proc.time()[["elapsed"]] - start) * 1e6)
}

timer_elapsed_millis <- function(start) {
  timer_elapsed_micros(start) %/% 1000L
}
