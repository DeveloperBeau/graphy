# Expression evaluation entry points.

apply_op <- function(op, a, b) {
  switch(op,
    "+" = a + b,
    "-" = a - b,
    "*" = a * b,
    "/" = {
      if (b == 0) stop("divide by zero")
      a / b
    },
    stop(sprintf("unknown operator %s", op))
  )
}

eval_expr <- function(expr) {
  stream <- token_stream(scan_tokens(expr))
  parse_expr(stream)
}
