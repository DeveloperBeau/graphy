# feature: library, require, source, function assignment
library(methods)
require(utils)
source("helpers.R")

run_service <- function(name) {
  greeting <- format_name(name)
  greeting
}

describe_service <- function(name) {
  paste0("Service(", name, ")")
}
