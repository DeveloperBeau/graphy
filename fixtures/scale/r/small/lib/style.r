# Text emphasis via ANSI escape codes.

style_bold <- function(text) {
  sprintf("\033[1m%s\033[0m", text)
}

style_underline <- function(text) {
  sprintf("\033[4m%s\033[0m", text)
}

apply_style <- function(style, text) {
  switch(style,
    bold = style_bold(text),
    underline = style_underline(text),
    text
  )
}
