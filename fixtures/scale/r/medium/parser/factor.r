# Numbers, unary minus and parenthesised groups.

parse_negate <- function(stream) {
  -parse_factor(stream)
}

parse_factor <- function(stream) {
  token <- stream_next(stream)
  if (is.null(token)) {
    stop("unexpected end of expression")
  }
  if (token$type == "NUM") {
    return(as.numeric(token$value))
  }
  if (token$value == "-") {
    return(parse_negate(stream))
  }
  if (token$value == "(") {
    inner <- parse_expr(stream)
    stream_next(stream)
    return(inner)
  }
  stop(sprintf("unexpected token %s", token$value))
}
