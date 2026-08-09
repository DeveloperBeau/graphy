# Horizontal alignment within a fixed width.

pad_left <- function(text, width) {
  formatC(text, width = width, flag = " ")
}

pad_right <- function(text, width) {
  formatC(text, width = -width, flag = " ")
}

center_text <- function(text, width) {
  lead <- (width - nchar(text)) %/% 2 + nchar(text)
  pad_left(text, lead)
}
