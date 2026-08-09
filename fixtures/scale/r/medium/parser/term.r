# Multiplicative term parsing.

is_multiplicative <- function(token) {
  !is.null(token) && token$type == "OP" && token$value %in% c("*", "/")
}

parse_term <- function(stream) {
  left <- parse_factor(stream)
  while (is_multiplicative(stream_peek(stream))) {
    op <- stream_next(stream)$value
    right <- parse_factor(stream)
    left <- apply_op(op, left, right)
  }
  left
}
