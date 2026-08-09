# Additive expression parsing.

is_additive <- function(token) {
  !is.null(token) && token$type == "OP" && token$value %in% c("+", "-")
}

parse_expr <- function(stream) {
  left <- parse_term(stream)
  while (is_additive(stream_peek(stream))) {
    op <- stream_next(stream)$value
    right <- parse_term(stream)
    left <- apply_op(op, left, right)
  }
  left
}
