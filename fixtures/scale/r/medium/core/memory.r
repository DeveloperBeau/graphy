# Single-slot memory register (M+, MR, MC).

.calc_memory <- new.env()
.calc_memory$value <- 0

mem_store <- function(value) {
  .calc_memory$value <- value
}

mem_recall <- function() {
  .calc_memory$value
}

mem_clear <- function() {
  .calc_memory$value <- 0
}
