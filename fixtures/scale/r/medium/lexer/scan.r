# Split an expression string into tokens.

scan_number <- function(chars, start) {
  end <- start
  while (end <= length(chars) && grepl("[0-9.]", chars[end])) {
    end <- end + 1
  }
  list(text = paste(chars[start:(end - 1)], collapse = ""), next_pos = end)
}

scan_tokens <- function(expr) {
  chars <- strsplit(expr, "")[[1]]
  tokens <- list()
  i <- 1
  while (i <= length(chars)) {
    c <- chars[i]
    if (c == " ") {
      i <- i + 1
    } else if (grepl("[0-9]", c)) {
      num <- scan_number(chars, i)
      tokens <- c(tokens, list(token_new("NUM", num$text)))
      i <- num$next_pos
    } else {
      tokens <- c(tokens, list(token_new("OP", c)))
      i <- i + 1
    }
  }
  tokens
}
