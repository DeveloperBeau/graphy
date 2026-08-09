# Box-drawing borders around rendered blocks.

border_rule <- function(width, ch = "-") {
  paste0("+", strrep(ch, width), "+")
}

border_wrap <- function(lines, width) {
  boxed <- sprintf("|%s|", formatC(lines, width = -width))
  c(border_rule(width), boxed, border_rule(width))
}
