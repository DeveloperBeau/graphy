# Calculator settings.

.calc_config <- new.env()
.calc_config$precision <- 6L
.calc_config$angle_unit <- "radians"

config_get <- function(name) {
  switch(name,
    precision = .calc_config$precision,
    angle_unit = .calc_config$angle_unit,
    stop(sprintf("unknown setting: %s", name))
  )
}

config_set_precision <- function(digits) {
  .calc_config$precision <- as.integer(digits)
}
