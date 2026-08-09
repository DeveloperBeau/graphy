# Fixed-width line wrapping.

wrap_line <- function(line, width) {
  chunks <- character(0)
  while (nchar(line) > width) {
    chunks <- c(chunks, substr(line, 1, width))
    line <- substr(line, width + 1, nchar(line))
  }
  c(chunks, line)
}

wrap_text <- function(lines, width) {
  unlist(lapply(lines, wrap_line, width = width))
}
