# Command-line option defaults.

.bench_options <- new.env()
.bench_options$rounds <- 16L
.bench_options$sample_size <- 512L

option_get <- function(name) {
  get(name, envir = .bench_options)
}

option_set <- function(name, value) {
  assign(name, value, envir = .bench_options)
}
