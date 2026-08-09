# ANSI color helpers.

color_code <- function(name) {
  codes <- c(red = 31, green = 32, yellow = 33, blue = 34, cyan = 36)
  if (name %in% names(codes)) codes[[name]] else 0
}

colorize <- function(name, text) {
  code <- color_code(name)
  sprintf("\033[%dm%s\033[0m", code, text)
}

strip_colors <- function(text) {
  gsub("\033\\[[0-9]+m", "", text)
}
