# feature: function assignment, constants
MAX_RETRIES <- 3
SERVICE_NAME <- "graphy-r-fixture"

new_state <- function(name) {
  list(name = name, active = FALSE)
}
